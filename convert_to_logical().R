convert_to_logical <- function(df, column_name, false_values = c()) {
  # Check if the column exists in the data frame
  if (!(column_name %in% colnames(df))) {
    stop(paste("Error: Column", column_name, "not found in the data frame."))
  }
  
  # Print initial information about the column
  cat("=== Converting Column:", column_name, "===\n")
  cat("Original Data Type:", class(df[[column_name]]), "\n")
  unique_vals <- unique(df[[column_name]])
  cat("Unique Values:", paste(unique_vals, collapse = ", "), "\n")
  
  # Handle factors by converting them to characters for accurate comparison
  if (is.factor(df[[column_name]])) {
    cat("Column is a factor. Converting to character for processing.\n")
    df[[column_name]] <- as.character(df[[column_name]])
  }
  
  # Convert the column to logical binary values
  # TRUE for values not in false_values and not NA
  # FALSE otherwise
  df[[column_name]] <- ifelse(
    is.na(df[[column_name]]) | df[[column_name]] %in% false_values,
    FALSE,
    TRUE
  )
  
  # Ensure the column is logical
  df[[column_name]] <- as.logical(df[[column_name]])
  
  # Print summary after conversion
  cat("Conversion Complete.\n")
  cat("New Data Type:", class(df[[column_name]]), "\n")
  cat("TRUE Count:", sum(df[[column_name]], na.rm = TRUE), "\n")
  cat("FALSE Count:", sum(!df[[column_name]], na.rm = TRUE), "\n")
  cat("===============================\n\n")
  
  # Return the modified data frame
  return(df)
}
