convert_yes_no_to_logical <- function(df, column_name) {
  # Check if the column exists in the data frame
  if(!(column_name %in% colnames(df))) {
    stop(paste("Column", column_name, "not found in the data frame"))
  }
  
  # Convert "yes" to TRUE, "no" to FALSE, and keep NA as is
  df[[column_name]] <- ifelse(df[[column_name]] == "yes", TRUE,
                              ifelse(df[[column_name]] == "no", FALSE, NA))
  
  # Return the modified data frame
  return(df)
}
