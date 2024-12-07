calc_AgeDev <- function(dataframe, column_name) {
  # Check if the column_name and "Decimal.Chronological.Age" exist in the dataframe
  if(!(column_name %in% colnames(dataframe))) {
    stop(paste("Column", column_name, "does not exist in the dataframe"))
  }
  
  if(!("Decimal.Chronological.Age" %in% colnames(dataframe))) {
    stop("Column 'Decimal.Chronological.Age' does not exist in the dataframe")
  }
  
  # Create the new column name by appending "AgeDev" to the column_name
  new_column_name <- paste0(column_name, "AgeDev")
  
  # Calculate the new column as the difference between column_name and Decimal.Chronological.Age
  dataframe[[new_column_name]] <- dataframe[[column_name]] - dataframe[["Decimal.Chronological.Age"]]
  
  # Return the modified dataframe
  return(dataframe)
}