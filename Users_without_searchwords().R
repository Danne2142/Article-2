# Load necessary library
library(data.table)

# Define the function
count_true_values <- function(file_path, ...) {
  # Load the dataframe
  df <- fread(file_path)
  
  # Get the list of column names passed as arguments
  columns <- list(...)
  
  # Create a logical condition that checks if any of the specified columns have a TRUE value
  condition <- Reduce(`|`, lapply(columns, function(col) df[[col]]))
  
  # Count the rows where the condition is TRUE
  true_count <- sum(condition, na.rm = TRUE)
  
  # Return the result
  return(true_count)
}
# 
# # Example usage
# file_path <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/df_EPICv1_old_with_all_collumns.csv"
# result <- count_true_values(file_path, "NR.NAD", "Antiaging.NAD", "AnotherColumn")
# 
# # Print the result
# print(paste("Number of rows with TRUE in any of the specified columns:", result))
