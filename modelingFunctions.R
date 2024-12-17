
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
  
  # print(summary_pooled)
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


model_exposure_wise<- function(path,outcome_vars, exposure_vars, covariate_vars){
  #Import functions
  # source("C:/Users/danie/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Program/fit_imputed_lm().R")
  # source("C:/Users/danie/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Program/fit_multiple_models().R")
  
  #import data
  load(path)
  
  combined_results_df <- fit_multiple_models(
    imputedData = imputed_data,
    exposures = exposure_vars,
    outcomes = outcome_vars,
    covariates = covariate_vars
  )

  return(combined_results_df)

}


