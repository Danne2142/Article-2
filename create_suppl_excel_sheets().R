# Load required libraries
library(readxl)
library(writexl)

# Function to combine multiple xlsx files into one
combine_xlsx_files <- function(input_directory, output_file) {
  # Get all xlsx files in the directory
  xlsx_files <- list.files(path = input_directory, 
                          pattern = "\\.xlsx$", 
                          full.names = TRUE)
  
  # Check if any xlsx files were found
  if (length(xlsx_files) == 0) {
    stop("No xlsx files found in the specified directory")
  }
  
  # Create an empty list to store data frames
  all_data <- list()
  
  # Read each xlsx file and add to the list
  for (file in xlsx_files) {
    # Extract file name without extension to use as sheet name
    sheet_name <- tools::file_path_sans_ext(basename(file))
    
    # Read the xlsx file
    df <- read_excel(file)
    
    # Add to list with the file name as the list name
    all_data[[sheet_name]] <- df
    
    # Print progress
    cat("Processed file:", file, "\n")
  }
  
  # Write the combined data to a new xlsx file
  write_xlsx(all_data, output_file)
  
  cat("All files have been combined into", output_file, "\n")
  cat("Total number of sheets created:", length(all_data), "\n")
}

# # Example usage:
# # Specify the directory containing your xlsx files
# input_dir <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results"

# # Specify the output file path
# output_file <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/combined.xlsx"

# # Run the function
# combine_xlsx_files(input_dir, output_file)