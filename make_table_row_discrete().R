
### Handle discrete variables


make_table_row_discrete <- function(covariate_column, outcome_column, young_old_boundary, df) {
  library(dplyr)
  
  
  # Split the dataframe into "young" and "old" based on the outcome_column
  young <- df[df[[outcome_column]] < young_old_boundary, ]
  old <- df[df[[outcome_column]] >= young_old_boundary, ]
  
  # Calculate the median and standard deviation for the covariate_column
  young_mean <- round(median(young[[covariate_column]], na.rm = TRUE), 1)
  young_std <- round(sd(young[[covariate_column]], na.rm = TRUE), 1)
  
  old_mean <- round(median(old[[covariate_column]], na.rm = TRUE), 1)
  old_std <- round(sd(old[[covariate_column]], na.rm = TRUE), 1)
  
  # Create the result strings
  young_results <- paste0(young_mean, " (", round(young_std, 1), ")")
  old_results <- paste0(old_mean, " (", round(old_std, 1), ")")
  
  # Perform a T-test between "old" and "young" for the covariate_column
  t_test <- wilcox.test(old[[covariate_column]], young[[covariate_column]], paired = FALSE)
  
  # Extract the p-value
  p_value <- format_pvalue(t_test$p.value)
  
  # Create a data.frame to store the result
  result_df <- data.frame(
    Variable = paste0(covariate_column, " (SD)"),
    Old = old_results,
    Young = young_results,
    `p-value` = p_value,
    stringsAsFactors = FALSE
  )
  
  # Return the result dataframe
  return(result_df)
}

# # Example usage:
# Table1 <- make_table_row_continuous("BMI", "DunedinPACE", young_old_boundary = 1, filtered_df_crossectional_harmonized)


