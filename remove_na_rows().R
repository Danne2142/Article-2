remove_na_rows <- function(df, columns) {
  # Check if all specified columns exist in the dataframe
  missing_cols <- setdiff(columns, names(df))
  if (length(missing_cols) > 0) {
    stop(paste("Error: The following columns are not in the dataframe:", 
               paste(missing_cols, collapse = ", ")))
  }
  
  # Identify rows with NA in any of the specified columns
  na_rows <- apply(df[, columns], 1, function(row) any(is.na(row)))
  
  # Count number of rows to remove
  num_rows_removed <- sum(na_rows)
  
  # Remove rows with NA in specified columns
  df_clean <- df[!na_rows, ]
  
  # Determine how many NAs were in each specified column
  na_counts <- sapply(columns, function(col) sum(is.na(df[[col]])))
  
  # Print summary information
  cat("Summary of NA Removal:\n")
  cat("-----------------------\n")
  cat("Total rows before removal:", nrow(df), "\n")
  cat("Total rows removed:", num_rows_removed, "\n")
  cat("Reason for removal: NA values in the following columns:\n")
  
  # Only display columns that had NAs
  cols_with_na <- na_counts[na_counts > 0]
  if (length(cols_with_na) > 0) {
    for (col in names(cols_with_na)) {
      cat(paste0(" - ", col, ": ", cols_with_na[col], " NA(s)\n"))
    }
  } else {
    cat("No NAs found in the specified columns.\n")
  }
  
  # Return the cleaned dataframe
  return(df_clean)
}