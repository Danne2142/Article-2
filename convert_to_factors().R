convert_to_factors <- function(df, columns) {
  # Check if columns exist in the data frame
  missing_cols <- setdiff(columns, names(df))
  if(length(missing_cols) > 0) {
    warning(paste("The following columns are not found in the data frame:", paste(missing_cols, collapse = ", ")))
  }
  
  # Convert each specified column to factor if it exists
  for (col in columns) {
    if (col %in% names(df)) {
      df[[col]] <- as.factor(df[[col]])
    }
  }
  
  # Return the modified data frame
  return(df)
}