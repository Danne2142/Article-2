remove_other <- function(df, col_name) {
  # Check if the column exists in the data frame
  if (!col_name %in% colnames(df)) {
    stop("Column not found in the data frame.")
  }
  
  # Filter out rows where the specified column contains "other"
  df_filtered <- df[!grepl("other", df[[col_name]], ignore.case = TRUE), ]
  
  return(df_filtered)
}

# Example usage:
# df <- data.frame(A = c("other", "apple", "banana"), B = c(1, 2, 3))
# remove_other(df, "A")
