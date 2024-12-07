get_Numeric_and_int_cols <- function(df, exclude_cols = NULL) {
  # Check if exclude_cols is provided and is a character vector
  if (!is.null(exclude_cols)) {
    if (!is.character(exclude_cols)) {
      stop("exclude_cols must be a character vector of column names.")
    }
    
    # Check if all exclude_cols exist in the dataframe
    missing_cols <- setdiff(exclude_cols, names(df))
    if (length(missing_cols) > 0) {
      warning("The following columns in exclude_cols do not exist in the dataframe and will be ignored: ",
              paste(missing_cols, collapse = ", "))
      # Exclude only the existing columns
      exclude_cols <- intersect(exclude_cols, names(df))
    }
  }
  
  # Use sapply to iterate over each column in the dataframe
  numeric_cols <- sapply(names(df), function(col_name) {
    # Skip the column if it's in exclude_cols
    if (!is.null(exclude_cols) && col_name %in% exclude_cols) {
      return(FALSE)
    }
    
    # Extract the column data
    col <- df[[col_name]]
    
    # Check if the column is of type numeric or integer
    is_numeric <- is.numeric(col) || is.integer(col)
    
    # Check if there's at least one value that's not 0, 1, or NA
    has_other_values <- any(!is.na(col) & !(col %in% c(0, 1)))
    
    # Return TRUE if both conditions are met
    is_numeric && has_other_values
  })
  
  # Extract the column numbers where the condition is TRUE
  which(numeric_cols)
}
