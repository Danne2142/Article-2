char_cols_to_factors <- function(df, uniq_val_thresh = 5, max_uniq_n = 1000, cols_to_skip = NULL) {
  # Validate cols_to_skip
  if (!is.null(cols_to_skip)) {
    if (!all(cols_to_skip %in% names(df))) {
      missing_cols <- cols_to_skip[!cols_to_skip %in% names(df)]
      stop(sprintf("The following columns to skip do not exist in the data frame: %s", 
                   paste(missing_cols, collapse = ", ")))
    }
  }
  
  # Iterate over each column
  for (colname in names(df)) {
    # Skip columns specified in cols_to_skip
    if (!is.null(cols_to_skip) && colname %in% cols_to_skip) {
      message(sprintf("Skipping column '%s' as it's specified in cols_to_skip.", colname))
      next
    }
    
    # Check if the column exists and is not NULL
    if (!is.null(df[[colname]])) {
      # Process only character columns
      if (is.character(df[[colname]])) {
        # Calculate unique non-NA values
        num_unique <- length(unique(na.omit(df[[colname]])))
        
        # Check against max_uniq_n
        if (num_unique > max_uniq_n) {
          stop(sprintf("Column '%s' has %d unique values, which exceeds the maximum allowed (%d).",
                       colname, num_unique, max_uniq_n))
        }
        
        # Inform about processing
        message(sprintf("Processing column '%s' with %d unique non-NA values.", colname, num_unique))
        
        if (num_unique > uniq_val_thresh) {
          message(sprintf(" - Converting '%s' to logical.", colname))
          
          # Convert to logical
          new_col <- df[[colname]]
          new_col_lower <- tolower(new_col)
          
          # Initialize as TRUE
          new_col_logical <- rep(TRUE, length(new_col))
          
          # Assign FALSE where applicable
          new_col_logical[new_col_lower %in% c("no", "none")] <- FALSE
          
          # Preserve NAs
          new_col_logical[is.na(new_col)] <- NA
          
          # Update the data frame
          df[[colname]] <- new_col_logical
          
          # Report conversion summary
          num_false <- sum(new_col_logical == FALSE, na.rm = TRUE)
          num_true <- sum(new_col_logical == TRUE, na.rm = TRUE)
          num_na <- sum(is.na(new_col_logical))
          message(sprintf("   - Converted to logical: %d TRUE, %d FALSE, %d NA", num_true, num_false, num_na))
        } else {
          message(sprintf(" - Converting '%s' to factor.", colname))
          
          # Convert to factor
          df[[colname]] <- as.factor(df[[colname]])
          
          # Report factor levels
          message(sprintf("   - Levels: %s", paste(levels(df[[colname]]), collapse = ", ")))
        }
      } else {
        message(sprintf("Skipping column '%s' (type: %s).", colname, class(df[[colname]])))
      }
    } else {
      message(sprintf("Column '%s' is NULL and will be skipped.", colname))
    }
  }
  
  message("Data frame processing complete.")
  return(df)
}