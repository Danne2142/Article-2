### Count N individuals
make_table_row_N_indivudals <- function(outcome_column, young_old_boundary, df) {
  # Split the dataframe into "young" and "old" based on the outcome_column
  young <- df[df[[outcome_column]] < young_old_boundary, ]
  old <- df[df[[outcome_column]] >= young_old_boundary, ]
  
  # Create the result strings
  young_results <- nrow(young)
  old_results <- nrow(old)
  
  p_value <- ""
  
  # Create a data.frame to store the result
  result_df <- data.frame(
    Variable = "N individuals",
    Old = old_results,
    Young = young_results,
    `p-value` = p_value,
    stringsAsFactors = FALSE
  )
  
  # Return the result dataframe
  return(result_df)
}
# output_df <- make_table_row_N_indivudals("DunedinPACE", young_old_boundary = 1, filtered_df_crossectional_harmonized)

