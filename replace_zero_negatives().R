replace_zero_negatives <- function(df, cols) {
  # Check if all specified columns exist in the dataframe
  missing_cols <- setdiff(cols, names(df))
  if(length(missing_cols) > 0) {
    stop(paste("The following columns are not in the dataframe:", paste(missing_cols, collapse = ", ")))
  }
  
  # Iterate over each specified column
  for(col in cols) {
    # Check if the column is numeric
    if(!is.numeric(df[[col]])) {
      warning(paste("Column", col, "is not numeric and will be skipped."))
      next
    }
    
    # Replace 0 and negative values with NA
    df[[col]][df[[col]] <= 0] <- NA
  }
  
  return(df)
}

replace_zero_negatives <- function(df, cols) {
  # Check if all specified columns exist in the dataframe
  missing_cols <- setdiff(cols, names(df))
  if(length(missing_cols) > 0) {
    stop(paste("The following columns are not in the dataframe:", paste(missing_cols, collapse = ", ")))
  }
  
  # Create logical vector for row filtering
  keep_rows <- rep(TRUE, nrow(df))
  
  # Iterate over each specified column
  for(col in cols) {
    # Check if the column is numeric
    if(!is.numeric(df[[col]])) {
      warning(paste("Column", col, "is not numeric and will be skipped."))
      next
    }
    
    # Update keep_rows to only include rows where values are positive
    keep_rows <- keep_rows & !is.na(df[[col]]) & df[[col]] > 0
  }
  
  # Return filtered dataframe
  return(df[keep_rows, ])
}