#' Remove terms from models if p-value > 0.15 across all models
#' 
#' @description
#' Evaluates terms across multiple models and removes those with p-value > 0.15 in all models.
#'  variables can be excluded from this evaluation.
#' 
#' @param terms Vector of term names to evaluate
#' @param dfs List of dataframes containing model results with columns 'term' and 'p.value'
#' @param variables_to_exclude Optional vector of  variable names to retain
#' 
#' @return Vector of remaining terms after removal
#' 

#' Format p-values in a dataframe for presentation
#' 
#' @description
#' Converts p-values to formatted strings: values < 0.05 become "<0.05", 
#' others are rounded to 2 decimal places
#' 
#' @param df Dataframe containing a 'p.value' column
#' @return Dataframe with formatted p-values
format_pvalues <- function(df) {
  # Check if p.value column exists in the dataframe
  if ("p.value" %in% colnames(df)) {
    # Format p-values: show "<0.05" for significant values, otherwise round to 2 decimals
    df$p.value <- ifelse(as.numeric(df$p.value) < 0.05,
                         "<0.05",
                         sprintf("%.2f", as.numeric(df$p.value)))
  } else {
    # Warn user if p.value column is missing
    warning("Column 'p.value' not found in the dataframe.")
    #warning(paste0("Column 'p.value' in data frame: ", df, "not found in the dataframe."))
  }
  return(df)
}

#' Remove terms with high p-values across all models
#' 
#' @description
#' Filters out terms that have p-value > 0.15 in ALL provided models.
#' Allows exclusion of specific variables from filtering (e.g., key exposures)
#' 
#' @param terms Vector of term names to evaluate for removal
#' @param dfs List of dataframes with model results (must contain 'term' and 'p.value' columns)
#' @param variables_to_exclude Optional vector of variable names to always retain
#' @return Vector of terms that should remain in subsequent models
remove_terms_if_p_large <- function(terms, dfs, variables_to_exclude = NULL) {
  # Initialize vectors to track which terms to keep vs remove
  remaining_terms <- c()
  removed_terms <- c()

  # Process each term individually
  for (term in terms) {
    print(term)  # Progress indicator

    # Handle excluded variables: always retain these regardless of p-value
    if (!is.null(variables_to_exclude) && term %in% variables_to_exclude) {
      remaining_terms <- c(remaining_terms, term)
      next  # Skip p-value evaluation for excluded variables
    }
    
    # Check if p-value exceeds 0.15 threshold in ALL models
    all_over_15 <- all(sapply(dfs, function(df) {
      # Find rows matching the current term
      row_match <- df[df$term == term, ]
      if(nrow(row_match) == 0) {
        # If term is not found in this model, don't remove it (return FALSE)
        return(FALSE)
      } else {
        # Return TRUE if p-value > 0.15 in this model
        row_match$p.value > 0.15
      }
    }))
    
    # Decision logic: keep term if significant in ANY model, remove if non-significant in ALL
    if (!all_over_15) {
      # Term is significant (p <= 0.15) in at least one model - keep it
      remaining_terms <- c(remaining_terms, term)
    } else {
      # Term has p > 0.15 in all models - remove it
      removed_terms <- c(removed_terms, term)
    }
  }
  
  # Report results to user
  if (length(removed_terms) > 0) {
    cat("\nRemoved terms with p > 0.15 in all models:\n")
    cat(paste("-", removed_terms), sep = "\n")
  } else {
    cat("\nNo terms were removed\n")
  }
  
  return(remaining_terms)
}

#' Fit linear regression model on multiply imputed data
#' 
#' @description
#' Fits linear regression using multiply imputed datasets and pools results using Rubin's rules.
#' Handles missing data through multiple imputation framework.
#' 
#' @param imputedData mids object from mice package containing imputed datasets
#' @param outcome String name of outcome variable
#' @param exposures Vector of exposure variable names
#' @param covariates Vector of covariate variable names
#' @return Dataframe with pooled regression results including confidence intervals
fit_imputed_lm <- function(imputedData, outcome, exposures, covariates) {
  
  # Load required package for multiple imputation analysis
  library(mice)
  
  # Validate input: ensure imputedData is proper mids object
  if (!inherits(imputedData, "mids")) {
    stop("imputedData must be a mids object from the mice package.")
  }
  
  # Combine exposures and covariates into single predictor vector
  predictors <- c(exposures, covariates)
  
  # Validate that all required variables exist in the imputed data
  all_vars <- c(outcome, predictors)
  missing_vars <- setdiff(all_vars, colnames(complete(imputedData, 1)))
  if (length(missing_vars) > 0) {
    stop(paste("The following variables are not in the data:", paste(missing_vars, collapse = ", ")))
  }
  
  # Build regression formula string: outcome ~ predictor1 + predictor2 + ...
  formula_str <- paste(outcome, "~", paste(predictors, collapse = " + "))
  
  # Fit linear regression model on each imputed dataset
  fit <- with(imputedData, lm(as.formula(formula_str)))
  
  # Pool results across imputed datasets using Rubin's rules
  pooled_results <- pool(fit)
  
  # Extract summary statistics with confidence intervals
  summary_pooled <- summary(pooled_results, conf.int = TRUE)
  
  # Convert to dataframe for easier handling
  results_df <- as.data.frame(summary_pooled)
  
  # Format p-values for presentation
  results_df <- format_pvalues(results_df)
  
  # Add outcome name as identifier column
  results_df$Outcome <- outcome  
  
  return(results_df)
}

#' Fit multiple regression models for different exposure-outcome combinations
#' 
#' @description
#' Runs separate regression models for each exposure-outcome pair, with each exposure
#' modeled individually (not simultaneously) against each outcome.
#' 
#' @param imputedData mids object with multiply imputed datasets
#' @param exposures Vector of exposure variable names to test
#' @param outcomes Vector of outcome variable names
#' @param covariates Vector of covariate names to include in all models
#' @return Named list of dataframes, one per outcome, containing results for all exposures
fit_multiple_models <- function(imputedData, exposures, outcomes, covariates) {
  # Load required packages
  library(dplyr)
  library(stringr)
  
  # Initialize list to store results for each outcome
  results_list <- list()
  
  # Loop through each outcome variable
  for (outcome_var in outcomes) {
    # Initialize dataframe to collect results for this outcome
    outcome_results_df <- data.frame()
    
    # Loop through each exposure variable for the current outcome
    for (exposure_var in exposures) {
      # Fit model with single exposure + covariates predicting current outcome
      result_df <- fit_imputed_lm(
        imputedData = imputedData,
        outcome = outcome_var,
        exposures = exposure_var,  # Single exposure at a time
        covariates = covariates
      )
      
      # Filter results to only include rows related to the exposure variable
      # (removes covariate results, keeps only exposure effects)
      exposure_results_df <- result_df %>%
        filter(str_detect(term, paste0("^", exposure_var)))
      
      # Add identifying columns for outcome and exposure
      exposure_results_df <- exposure_results_df %>%
        mutate(Outcome = outcome_var, Exposure = exposure_var)
      
      # Combine with other exposures for this outcome
      outcome_results_df <- rbind(outcome_results_df, exposure_results_df)
    }
    
    # Store results for this outcome in the main results list
    results_list[[outcome_var]] <- outcome_results_df
  }
  
  return(results_list)
}

#' Inspect data columns for modeling compatibility
#' 
#' @description
#' Validates that specified columns exist, contain varying values, and have no missing data.
#' Stops execution with informative error if data issues are found.
#' 
#' @param df Dataframe to inspect
#' @param cols Vector of column names to check
#' @return No return value (function stops on error or prints success messages)
inspect_columns <- function(df, cols) {
  # Check each specified column
  for (col in cols) {
    # Error if column doesn't exist
    if (!col %in% names(df)) {
      stop(sprintf("Error: Column '%s' does not exist in the dataframe.", col))
    }
    
    # Extract column data and count missing values
    col_data <- df[[col]]
    na_count <- sum(is.na(col_data))
    unique_vals <- unique(na.omit(col_data))  # Get unique non-missing values
    
    # Error if column is uniform (no variation)
    if (length(unique_vals) <= 1) {
      stop(sprintf("Error: Column '%s' is uniform%s.", col,
                   if(na_count > 0) sprintf(" with %d NA(s)", na_count) else ""))
    } 
    # Error if column has missing values
    else if (na_count > 0) {
      stop(sprintf("Error: Column '%s' has %d NA(s) and varying values.", col, na_count))
    } 
    # Success message if column passes all checks
    else {
      cat(sprintf("Column '%s' has varying values and no NAs.\n", col))
    }
  }
}

#' Run exposure-wise modeling analysis
#' 
#' @description
#' Wrapper function that fits multiple models testing each exposure individually
#' against multiple outcomes, controlling for specified covariates.
#' 
#' @param imputed_data mids object with multiply imputed datasets
#' @param outcome_vars Vector of outcome variable names
#' @param exposure_vars Vector of exposure variable names to test
#' @param covariate_vars Vector of covariate names for adjustment
#' @return List of dataframes with model results, organized by outcome
model_exposure_wise<- function(imputed_data,outcome_vars, exposure_vars, covariate_vars){
  # Note: Import functions are commented out (assumed to be sourced elsewhere)
  # source("C:/Users/danie/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Program/fit_imputed_lm().R")
  # source("C:/Users/danie/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Program/fit_multiple_models().R")
  
  # Fit multiple models using the exposure-wise approach
  # Each exposure is tested separately against each outcome
  combined_results_df <- fit_multiple_models(
    imputedData = imputed_data,
    exposures = exposure_vars,
    outcomes = outcome_vars,
    covariates = covariate_vars
  )

  # Note: p-value formatting is handled within fit_imputed_lm, so this line is commented out
  # to avoid processing the list structure incorrectly
  # combined_results_df<-format_pvalues(combined_results_df)
  
  return(combined_results_df)
}
