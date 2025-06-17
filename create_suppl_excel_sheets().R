# Load required libraries
# install.packages("readxl")
library(readxl)
library(writexl)

# Function to combine multiple xlsx files into one
combine_xlsx_files <- function(input_directory, output_file) {
  # Get all xlsx files in the directory
  xlsx_files <- list.files(path = input_directory, 
                          pattern = "\\.xlsx$", 
                          full.names = TRUE)
  
  # Exclude the output file from the input files list to prevent self-inclusion
  output_basename <- basename(output_file)
  xlsx_files <- xlsx_files[basename(xlsx_files) != output_basename]
  
  # Check if any xlsx files were found
  if (length(xlsx_files) == 0) {
    stop("No xlsx files found in the specified directory (excluding output file)")
  }
  
  # Create an empty list to store data frames
  all_data <- list()
  
  # Read each xlsx file and add to the list
  for (file in xlsx_files) {
    # Extract file name without extension to use as sheet name
    original_name <- tools::file_path_sans_ext(basename(file))
    
    # Remove common prefixes like "meta_"
    cleaned_name <- original_name
    if (startsWith(cleaned_name, "meta_")) {
      cleaned_name <- substring(cleaned_name, 6)  # Remove "meta_" (5 chars + 1)
      cat("Removed prefix 'meta_':", original_name, "->", cleaned_name, "\n")
    }
    
    # Replace "european" with "euro"
    if (grepl("european", cleaned_name, ignore.case = TRUE)) {
      original_cleaned <- cleaned_name
      cleaned_name <- gsub("european", "euro", cleaned_name, ignore.case = TRUE)
      cat("Replaced 'european' with 'euro':", original_cleaned, "->", cleaned_name, "\n")
    }
    
    # Remove "_table" suffix
    if (endsWith(cleaned_name, "_table")) {
      original_cleaned <- cleaned_name
      cleaned_name <- substr(cleaned_name, 1, nchar(cleaned_name) - 6)  # Remove "_table" (6 chars)
      cat("Removed '_table' suffix:", original_cleaned, "->", cleaned_name, "\n")
    }
    
    # Check if name needs truncation
    if (nchar(cleaned_name) > 31) {
      truncated_name <- substr(cleaned_name, 1, 31)
      cat("Sheet name truncated:", cleaned_name, "->", truncated_name, "\n")
    } else {
      truncated_name <- cleaned_name
    }
    
    # Handle duplicate names by adding counter
    sheet_name <- truncated_name
    counter <- 1
    while (sheet_name %in% names(all_data)) {
      # Calculate how much space we need for the counter suffix
      suffix <- paste0("_", counter)
      max_base_length <- 31 - nchar(suffix)
      
      sheet_name <- paste0(substr(truncated_name, 1, max_base_length), suffix)
      cat("Sheet name deduplicated:", truncated_name, "->", sheet_name, "\n")
      counter <- counter + 1
    }
    
    # Read the xlsx file
    df <- read_excel(file)
    
    # Add to list with the final sheet name
    all_data[[sheet_name]] <- df
    
    # Print progress
    cat("Processed file:", basename(file), "-> Sheet:", sheet_name, "\n")
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