#' Remove terms from models if p-value > 0.15 across all models
#' 
#' @description
#' Evaluates terms across multiple models and removes those with p-value > 0.15 in all models.
#' Categorical variables can be excluded from this evaluation.
#' 
#' @param terms Vector of term names to evaluate
#' @param dfs List of dataframes containing model results with columns 'term' and 'p.value'
#' @param categorical_variables_to_exclude Optional vector of categorical variable names to retain
#' 
#' @return Vector of remaining terms after removal
#' 
#' 
format_pvalues <- function(df) {
  if ("p.value" %in% colnames(df)) {
    df$p.value <- ifelse(as.numeric(df$p.value) < 0.05,
                         "<0.05",
                         sprintf("%.2f", as.numeric(df$p.value)))
  } else {
    warning("Column 'p.value' not found in the dataframe.")
  }
  return(df)
}

remove_terms_if_p_large <- function(terms, dfs, categorical_variables_to_exclude = NULL) {
  # Initialize storage vectors
  remaining_terms <- c()
  removed_terms <- c()

  # Process each term
  for (term in terms) {
    print(term)

    # Handle categorical variables: retain regardless of p-value
    if (!is.null(categorical_variables_to_exclude) && term %in% categorical_variables_to_exclude) {
      remaining_terms <- c(remaining_terms, term)
      next
    }
    
    # Check if p-value exceeds threshold in all models
    all_over_15 <- all(sapply(dfs, function(df) {
      row_match <- df[df$term == term, ]
      row_match$p.value > 0.15
    }))
    
    # Track results: keep term if significant in any model
    if (!all_over_15) {
      remaining_terms <- c(remaining_terms, term)
    } else {
      removed_terms <- c(removed_terms, term)
    }
  }
  
  # Report results
  if (length(removed_terms) > 0) {
    cat("\nRemoved terms with p > 0.15 in all models:\n")
    cat(paste("-", removed_terms), sep = "\n")
  } else {
    cat("\nNo terms were removed\n")
  }
  
  return(remaining_terms)
}

fit_imputed_lm <- function(imputedData, outcome, exposures, covariates) {
  
  # Load necessary library
  library(mice)
  
  # Check if imputedData is a mids object
  if (!inherits(imputedData, "mids")) {
    stop("imputedData must be a mids object from the mice package.")
  }
  
  # Combine exposures and covariates into predictors
  predictors <- c(exposures, covariates)
  
  # Ensure that all variables are in the data
  all_vars <- c(outcome, predictors)
  missing_vars <- setdiff(all_vars, colnames(complete(imputedData, 1)))
  if (length(missing_vars) > 0) {
    stop(paste("The following variables are not in the data:", paste(missing_vars, collapse = ", ")))
  }
  
  # Build the model formula
  formula_str <- paste(outcome, "~", paste(predictors, collapse = " + "))
  
  # Fit the linear regression model on the imputed datasets
  fit <- with(imputedData, lm(as.formula(formula_str)))
  
  # Pool the results using Rubin's rules
  pooled_results <- pool(fit)
  
  # Get the summary with confidence intervals
  summary_pooled <- summary(pooled_results, conf.int = TRUE)
  
  # Convert summary to a dataframe
  results_df <- as.data.frame(summary_pooled)
  
  results_df<-format_pvalues(results_df)

  return(results_df)
}

fit_multiple_models <- function(imputedData, exposures, outcomes, covariates) {
  library(dplyr)
  library(stringr)
  
  results_list <- list()
  
  for (outcome_var in outcomes) {
    outcome_results_df <- data.frame()
    
    for (exposure_var in exposures) {
      result_df <- fit_imputed_lm(
        imputedData = imputedData,
        outcome = outcome_var,
        exposures = exposure_var,
        covariates = covariates
      )
      
      # Adjusted filtering for categorical variables
      exposure_results_df <- result_df %>%
        filter(str_detect(term, paste0("^", exposure_var)))
      
      exposure_results_df <- exposure_results_df %>%
        mutate(Outcome = outcome_var, Exposure = exposure_var)
      
      outcome_results_df <- rbind(outcome_results_df, exposure_results_df)
    }
    
    results_list[[outcome_var]] <- outcome_results_df
  }
  
  return(results_list)
}



model_exposure_wise<- function(imputed_data,outcome_vars, exposure_vars, covariate_vars){
  #Import functions
  # source("C:/Users/danie/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Program/fit_imputed_lm().R")
  # source("C:/Users/danie/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Program/fit_multiple_models().R")
  

  combined_results_df <- fit_multiple_models(
    imputedData = imputed_data,
    exposures = exposure_vars,
    outcomes = outcome_vars,
    covariates = covariate_vars
  )

  combined_results_df<-format_pvalues(combined_results_df)
  return(combined_results_df)

}

