### Count N individuals
make_table_only_false_values <- function(df, binary_var, outcome_column, young_old_boundary) {
  # Split the dataframe into "young" and "old" based on the outcome_column
  young <- df[df[[outcome_column]] < young_old_boundary, ]
  old <- df[df[[outcome_column]] >= young_old_boundary, ]
  
  # Create the result strings
  young_results <- nrow(filter(young, binary_var==FALSE))
  old_results <- nrow(filter(old, binary_var==FALSE))
  
  p_value <- ""
  
  # Create a data.frame to store the result
  result_df <- data.frame(
    Variable = binary_var,
    Old = old_results,
    Young = young_results,
    `p-value` = p_value,
    stringsAsFactors = FALSE
  )
  
  # Return the result dataframe
  return(result_df)
}
# output_df <- make_table_row_N_indivudals("DunedinPACE", young_old_boundary = 1, filtered_df_crossectional_harmonized)

