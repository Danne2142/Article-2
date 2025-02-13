z_transform <- function(df, col_name) {
  # Check if the column exists in the data frame
  if (!col_name %in% names(df)) {
    stop("Column not found in the data frame.")
  }
  
  # Extract the column data
  col_data <- df[[col_name]]
  
  # Verify that the column is numeric
  if (!is.numeric(col_data)) {
    stop("Column must be numeric for z-transformation.")
  }
  
  # Calculate the z-score (subtract mean and divide by standard deviation)
  z <- (col_data - mean(col_data, na.rm = TRUE)) / sd(col_data, na.rm = TRUE)
  
  # Append the z-transformed column to the data frame
  df[[paste0(col_name, "_z")]] <- z
  
  return(df)
}