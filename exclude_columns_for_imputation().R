
# Define the function
exclude_columns_for_imputation <- function(data, exclude_cols) {
  # Function to exclude specified columns from being used as predictors
  # and from being imputed in the mice package.
  #
  # Args:
  #   data: A data.frame containing the dataset with missing values.
  #   exclude_cols: A character vector of column names to exclude from
  #                 being used as predictors and from being imputed.
  #
  # Returns:
  #   A list containing the updated predictor matrix and imputation methods.
  
  # Check if exclude_cols are present in the data
  missing_cols <- setdiff(exclude_cols, names(data))
  if(length(missing_cols) > 0){
    stop(paste("The following columns are not in the data:", paste(missing_cols, collapse = ", ")))
  }
  
  # Create the default predictor matrix
  predictor_matrix <- make.predictorMatrix(data)
  
  # Set the excluded columns to not be used as predictors
  predictor_matrix[, exclude_cols] <- 0
  

  
  # Return the updated predictor matrix and methods
  return(predictor_matrix)
}
