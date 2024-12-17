
# Shorten column names for the VIM package
shorten_colnames <- function(df, max_length = 14) {
  names(df) <- substr(names(df), 1, max_length)
  return(df)
}


# Load necessary package
# Ensure that the VIM package is installed. If not, install it using:
# install.packages("VIM")

# Define the function
save_missing_data_plot <- function(
    data,
    survey_version_filter,
    output_dir = ".",          # Directory to save the PNG file
    filename_prefix = "missing_data_before_imputation_for_survey_version_",
    width = 10000,             # Width of the PNG in pixels
    height = 1200,             # Height of the PNG in pixels
    res = 150,                 # Resolution of the PNG
    mar = c(15, 4, 4, 2) + 0.1, # Margin settings
    cex_axis = 0.6,            # Axis label size
    gap = 0.5,                 # Gap between bars
    y_labels = c("Missing Data", "Pattern") # Y-axis labels
) {
  
  library(VIM)
  
  data <- subset(data, survey_version == survey_version_filter)
  
  
  #shorten_colnames
  data <- shorten_colnames(data)

  # Construct the filename
  filename <- paste0(filename_prefix, survey_version_filter, ".png")
  
  # Create the full file path
  filepath <- file.path(output_dir, filename)
  
  # Open the PNG device
  png(filename = filepath, width = width, height = height, res = res)
  
  # Adjust graphical parameters
  par(mar = mar)
  
  # Generate the aggregated missing data plot
  aggr(
    data,
    numbers = TRUE,
    sortVars = TRUE,
    labels = names(data),
    cex.axis = cex_axis,
    gap = gap,
    ylab = y_labels
  )
  
  # Close the PNG device
  dev.off()
  
  # Optional: Inform the user
  message("Plot saved to ", filepath)
}


set_NA_percent_and_imp_cols <- function(data, survey_version_filter, missing_threshold) {
  # Load necessary libraries
  library(dplyr)
  library(mice)
  library(VIM)
  

  # Filter survey version based on the provided filter
  survey <- subset(data, survey_version == survey_version_filter)
  
  # Function to calculate the percentage of missing values
  pMiss <- function(x) {
    # cat(" sum(is.na(x)): ")
    # cat(sum(is.na(x)))
    round(sum(is.na(x)) / length(x) * 100, 2)  # Rounded to 2 decimal places
  }
  
  # Calculate missing values for each column
  column_missing <- apply(survey, 2, pMiss)
  
  # Print missing percentage for each column in a readable format
  cat("Percentage of Missing Values by Column:\n")
  for (col_name in names(column_missing)) {
    cat(sprintf(" - %s: %.2f%% missing\n", col_name, column_missing[col_name]))
  }
  
  # # Optionally, calculate and print missing values for each row
  # row_missing <- sapply(survey, 1, pMiss)
  
  # Identify columns with missing percentage above the threshold
  columns_above_threshold <- which(column_missing > missing_threshold)
  
  cat("\nColumns Exceeding Missing Threshold:\n")
  if (length(columns_above_threshold) > 0) {
    for (col_index in columns_above_threshold) {
      cat(sprintf(" - %s: %.2f%% missing (dropped)\n", 
                  names(survey)[col_index], 
                  column_missing[col_index]))
    }
    cat(sprintf("Total number of columns dropped: %d\n", length(columns_above_threshold)))
    
    # Drop the columns exceeding the missing threshold
    survey <- survey[, -columns_above_threshold]
  } else {
    cat(sprintf("No columns with more than %.2f%% missing values.\n", missing_threshold))
  }
  
  return(survey)
}


# Define the function
exclude_columns_from_predictors_matrix <- function(data, exclude_cols) {
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



impute_survey <- function(data, survey_version_filter, missing_data_threshold = 50, imputation_seed = 12345, number_of_mice_datasets_to_impute = 5, 
max_iterations = 65, cols_to_exclude_from_predictors = c("Patient.ID", "PID", "Collection.Date", "Array", "survey_version")) {
  
  data <- subset(data, survey_version == survey_version_filter)
  
  # # Separate columns to keep unimputed
  # if (!is.null(cols_to_exclude_from_imputation_entirely)) {
  #   unimputed_data <- data[, cols_to_exclude_from_imputation_entirely, drop = FALSE]
  #   data <- data[, !(names(data) %in% cols_to_exclude_from_imputation_entirely)]
  # }
  
  # Load necessary library
  library(mice)
  predictor_matrix <- exclude_columns_from_predictors_matrix(data, cols_to_exclude_from_predictors)
  
  start <- Sys.time()
  df_imp <- mice(data, seed = imputation_seed, m = number_of_mice_datasets_to_impute, maxit = max_iterations, print = TRUE, tol = 1e-17, predictorMatrix = predictor_matrix)
  running_time <- Sys.time() - start
  
  cat("Run time: ")
  cat(running_time)
  df_imp$loggedEvents
  
  # # Add unimputed columns back to each imputed dataset
  # if (!is.null(cols_to_exclude_from_imputation_entirely)) {
  #   completed_datasets <- list()
  #   for (i in 1:number_of_mice_datasets_to_impute) {
  #     completed_data <- complete(df_imp, i)
  #     completed_data <- cbind(completed_data, unimputed_data)
  #     completed_datasets[[i]] <- completed_data
  #   }
  #   df_imp$completedDatasets <- completed_datasets
  # }
  
  return(df_imp)
  
}



# dplyr Function to Exclude Columns
exclude_columns_dplyr <- function(df, exclude_cols) {
  library(dplyr)
  
  #' Exclude specified columns from a data frame using dplyr.
  #'
  #' @param df A data frame from which columns will be excluded.
  #' @param exclude_cols A character vector of column names to exclude.
  #'
  #' @return A modified data frame with specified columns excluded.
  #'
  #' @examples
  #' df_modified <- exclude_columns_dplyr(df, c("B", "D"))
  
  if (!is.data.frame(df)) {
    stop("The input 'df' must be a data frame.")
  }
  
  if (!is.character(exclude_cols)) {
    stop("The 'exclude_cols' parameter must be a character vector.")
  }
  
  if (length(exclude_cols) > 0) {
    # Ensure that columns to exclude exist in the data frame
    exclude_cols <- intersect(exclude_cols, names(df))
    
    if (length(exclude_cols) > 0) {
      # Use dplyr's select with negative selection to exclude columns
      df <- df %>% select(-all_of(exclude_cols))
    }
  }
  
  return(df)
}

average_missing <- function(df) {
  total_elements <- prod(dim(df))
  missing_elements <- sum(is.na(df))
  average_missing <- missing_elements / total_elements
  return(average_missing)
}

