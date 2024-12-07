seperate_survey <- function(df, cols) {
  # Ensure the specified columns exist in the data frame
  valid_cols <- cols[cols %in% names(df)]
  
  print("Valid cols: ")
  print(valid_cols)
  
  
  # If there are no valid columns, return both data frames as empty
  if (length(valid_cols) == 0) {
    return(list(filtered = data.frame(), removed = df))
  }
  
  # Create a logical vector indicating which rows to keep
  keep_rows <- apply(df[valid_cols], 1, function(row) any(!is.na(row) & row != ""))
  
  # Print how many hits each column generated
  for (col in valid_cols) {
    hits <- sum(!is.na(df[[col]]) & df[[col]] != "")
    cat("Column", col, "has", hits, "hits.\n")
  }
  
  # Subset the original data frame based on the logical vector
  df_filtered <- df[keep_rows, , drop = FALSE]
  df_removed <- df[!keep_rows, , drop = FALSE]
  
  # Return both data frames as a list
  return(list(survey_with_cols = df_filtered, survey_without_cols = df_removed))
}