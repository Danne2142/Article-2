logical_to_integer <- function(df) {
  logical_cols <- sapply(df, is.logical)
  logical_cols_names <- names(df)[logical_cols]
  
  for (colname in logical_cols_names) {
    cat("Converting column '", colname, "' from logical to integer.\n", sep = "")
    df[[colname]] <- as.integer(df[[colname]])
  }
  
  return(df)
}
