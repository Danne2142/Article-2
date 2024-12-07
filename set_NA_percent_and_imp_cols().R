
set_NA_percent_and_imp_cols <- function(file_path, survey_version_filter = 1, missing_threshold = 40) {
  library(dplyr)
  library(mice)
  library(VIM)
  
  # Load the data
  filtered_df_crossectional_harmonized <- read.csv(file_path, header = TRUE, stringsAsFactors = FALSE)
  
  
  # Filter survey version based on parameter
  survey <- filter(filtered_df_crossectional_harmonized, survey_version == survey_version_filter)
  
  
  # Function to calculate percentage of missing values
  pMiss <- function(x) {round(sum(is.na(x)) / length(x) * 100, 2)}  # Rounded to 2 decimal places
  
  # Calculate missing values for each column and row
  column_missing <- apply(survey, 2, pMiss)
  row_missing <- apply(survey, 1, pMiss)
  
  # Identify and report columns with more than 5% missing values
  columns_above_5 <- which(column_missing > 5)
  if (length(columns_above_5) > 0) {
    cat(paste("Columns with more than 5% missing values:", paste(names(survey)[columns_above_5], collapse = ", ")))
    cat(paste("Total number of columns with more than 5% missing values:", length(columns_above_5)))
    cat("Percentage of missing values for each column with more than 5% missing values:")
    cat(column_missing[columns_above_5])
  } else {
    cat("No columns with more than 5% missing values.")
  }
  
  # # Identify and report rows with more than 5% missing values
  # rows_above_5 <- which(row_missing > 5)
  # if (length(rows_above_5) > 0) {
  #   cat(paste("Rows with more than 5% missing values:", paste(rows_above_5, collapse = ", ")))
  #   cat(paste("Total number of rows with more than 5% missing values:", length(rows_above_5)))
  #   cat("Percentage of missing values for each row with more than 5% missing values:")
  #   cat(row_missing[rows_above_5])
  # } else {
  #   cat("No rows with more than 5% missing values.")
  # }
  
  # Drop columns with more than the specified threshold of missing values
  columns_above_threshold <- which(column_missing > missing_threshold)
  if (length(columns_above_threshold) > 0) {
    cat(paste("Columns with more than", missing_threshold, "% missing values (dropped):", paste(names(survey)[columns_above_threshold], collapse = ", ")))
    cat(paste("Total number of columns dropped:", length(columns_above_threshold)))
    survey <- survey[, -columns_above_threshold]
  } else {
    cat(paste("No columns with more than", missing_threshold, "% missing values."))
  }
  
  # Shorten column names for the VIM package
  shorten_colnames <- function(df, max_length = 14) {
    names(df) <- substr(names(df), 1, max_length)
    return(df)
  }
  
  # Shorten column names
  survey_short <- shorten_colnames(survey)
  
  # Export the aggr plot for missing data to a PNG file
  png(paste0("aggr_plot_missing_data_survey_version_", survey_version_filter, ".png"), width = 10000, height = 1200, res = 150)
  par(mar = c(15, 4, 4, 2) + 0.1)  # Adjust graphical parameters for larger margin
  aggr(
    survey_short,
    numbers = TRUE,
    sortVars = TRUE,
    labels = names(survey_short),
    cex.axis = 0.6,      # Smaller axis labels
    gap = 0.5,
    ylab = c("Missing Data", "Pattern")
  )
  dev.off()
  
  return(survey)
}
