remove_outliers_sd <- function(data, col, k = 3, remove_na = TRUE) {
  # Check if the column exists in the data frame
  if(!col %in% names(data)) {
    stop(paste("Column", col, "not found in the data frame."))
  }
  
  # Extract the column data
  column_data <- data[[col]]
  
  # Calculate mean and standard deviation, excluding NAs
  mean_val <- mean(column_data, na.rm = TRUE)
  sd_val <- sd(column_data, na.rm = TRUE)
  
  # Define lower and upper bounds
  lower_bound <- mean_val - (k * sd_val)
  upper_bound <- mean_val + (k * sd_val)
  
  # Create a logical vector for non-outliers
  non_outliers <- (column_data >= lower_bound & column_data <= upper_bound)
  
  # Handle NAs
  if(remove_na) {
    non_outliers <- non_outliers & !is.na(column_data)
  }
  
  # Subset the data frame to exclude outliers
  cleaned_data <- data[non_outliers, ]
  
  return(cleaned_data)
}
