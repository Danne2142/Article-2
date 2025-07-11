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



impute_survey <- function(data, survey_version_filter, missing_data_threshold = 50, imputation_seed = 94956, number_of_mice_datasets_to_impute = 5, 
max_iterations = 65, cols_to_exclude_from_predictors = c("You need to exclude cols from predictor matrix!"), view_predictors_matrix = FALSE) {
  
  data <- subset(data, survey_version == survey_version_filter)
  
  # # Separate columns to keep unimputed
  # if (!is.null(cols_to_exclude_from_imputation_entirely)) {
  #   unimputed_data <- data[, cols_to_exclude_from_imputation_entirely, drop = FALSE]
  #   data <- data[, !(names(data) %in% cols_to_exclude_from_imputation_entirely)]
  # }
  
  # Load necessary library
  library(mice)
  predictor_matrix <- exclude_columns_from_predictors_matrix(data, cols_to_exclude_from_predictors)

  if(view_predictors_matrix) {
    View(predictor_matrix)
  }
  
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
  if(total_elements == 0) {
    return(0)  # Prevent division by zero if df is empty
  }
  missing_elements <- sum(is.na(df))
  average_missing <- missing_elements / total_elements
  return(average_missing)
}


impute_survey_data <- function(data_to_drop_cols_from, surveyVersion, missing_threshold = 50, 
                                 amount_of_mice_datasets_to_impute = 2, max_iterations_per_dataset = 1, 
                                 cols_to_exclude_from_imputation_entirely = NULL, 
                                 cols_to_exclude_from_predictors = c("You need to exclude cols that you do not want to impute from the predictor matrix, e.g. Patient.ID, PID, Collection.Date, Array, survey_version, OMICmAgeAgeDev, GrimAge.PCAgeDev, Hannum.PCAgeDev, Horvath.PCAgeDev,",
), 
                                 savePath = NULL, view_predictors_matrix = TRUE){
  # Adjust this according to each survey

  #------------------------------------
 
  # str(data_to_drop_cols_from)
  data_to_drop_cols_from <- subset(data_to_drop_cols_from, survey_version == surveyVersion) ##Important row!!


  # # Save a plot of how the data looks before cols with more missing data than the threshold is dropped
  #   save_missing_data_plot(
  #     data =  data_to_drop_cols_from,
  #     survey_version_filter = surveyVersion,
  #     output_dir= "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output", # Replace with your desired directory,
  #     filename_prefix = "missing_data_before_removal_of_cols_for_survey_version_"
  #   )
  #Prepare data for imputation by removing columns with more missing data than threshold
  df_to_impute<-set_NA_percent_and_imp_cols(data = data_to_drop_cols_from, survey_version_filter = surveyVersion, missing_threshold = missing_threshold)


  #Debugging
  missing_cols <- setdiff(cols_to_exclude_from_imputation_entirely, names(df_to_impute))
  print(missing_cols)

  cols_not_to_impute <- df_to_impute[, cols_to_exclude_from_imputation_entirely, drop = FALSE]
  df_to_impute <- df_to_impute[, !(names(df_to_impute) %in% cols_to_exclude_from_imputation_entirely)]
  
  if(ncol(df_to_impute) == 0){
    stop("Error: No columns remaining for imputation after excluding specified columns.")
  }
    
    
  # # Save a plot of how the data looks before imputation
  # save_missing_data_plot(
  #   data = df_to_impute,
  #   survey_version_filter = surveyVersion,
  #   output_dir= "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output", # Replace with your desired directory,
  #   filename_prefix = "missing_data_after_removal_of_cols_for_survey_version_"
  # )
    
  #Set amount_of_mice_datasets_to_impute
  avg_missing_data <-average_missing(df_to_impute) #These days there is a rule of thumb to use whatever the average percentage rate of missingness is
  print(paste0("Average proportion of missing data: ", avg_missing_data))

  # Perform imputation
  start <- Sys.time()
  imputed_data<-impute_survey(data=df_to_impute, survey_version_filter =surveyVersion, 
  missing_data_threshold =missing_threshold, imputation_seed=94956, number_of_mice_datasets_to_impute=amount_of_mice_datasets_to_impute, 
  max_iterations=max_iterations_per_dataset,  cols_to_exclude_from_predictors = cols_to_exclude_from_predictors, view_predictors_matrix = view_predictors_matrix)
    
  # # Add unimputed columns back to each imputed dataset
  # completed_datasets <- list()
  # for (i in 1:amount_of_mice_datasets_to_impute) {
  #   completed_data <- complete(imputed_data, i)
  #   completed_data <- cbind(completed_data, cols_not_to_impute)
  #   completed_datasets[[i]] <- completed_data
  # }
  # imputed_data$completedDatasets <- completed_datasets

  # imputed_dataframe1 <-imputed_data$completedDatasets[[1]]

  # # Sort for testing
  #   imputed_dataframe1 <- imputed_dataframe1 %>%
  #   arrange(Exercise.per.week)

  # Save a plot of how the data looks after imputation (first data frame)
  # save_missing_data_plot(
  #   data = imputed_dataframe1,
  #   survey_version_filter = surveyVersion,
  #   output_dir= "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output", # Replace with your desired directory,
  #   filename_prefix = "missing_data_after_imputation_for_survey_version_"
  # )

  # Save the imputed datasets to a file
  save(imputed_data, file = savePath)




  running_time = Sys.time() - start
  print(running_time) # check how long it runs

  # #Inspect imputation
  # plot(imputed_data)
  # autocorr.plot(imputed_data)
  # densityplot(imputed_data)
  # stripplot(imputed_data)

}



# Function to impute data
impute_survey_and_sensitivity_analysis <- function(
  path_to_data=NULL, 
  cols_to_exclude = NULL,
  cols_to_exclude_from_predictors = c("You need to exclude cols that you do not want to impute from the predictor matrix, e.g. Patient.ID, PID, Collection.Date, Array, survey_version, OMICmAgeAgeDev, GrimAge.PCAgeDev, Hannum.PCAgeDev, Horvath.PCAgeDev,"),
  surv_number = NULL,
  max_NA_percent_to_remove_cols_main_models = NULL,
  max_NA_percent_to_remove_cols_NON_main_models = NULL,
  number_of_mice_datasets_to_impute = NULL,
  maximum_iterations_per_dataset = NULL,
  exclude_diabetes_subgroups = FALSE,
  view_predictors_matrix=TRUE
  ) {
  # Load necessary libraries
  library(dplyr)
  library(mice)
  library(VIM)
  

# Load the data{
load(paste0(path_to_data, "data_after_step4"))

# Rename dataframe in this new script
data<-data_with_ageDev
rm(data_with_ageDev) # Remove old dataframe

### Impute  - All participants
print("Imputing for all participants...")


impute_survey_data(data_to_drop_cols_from=data, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_all_participants"),
                                 view_predictors_matrix = view_predictors_matrix)



 if(exclude_diabetes_subgroups==FALSE){ #Do imputation for diabetes subgroups   exclude_diabetes_subgroups = FALSE make it only happen to survey 1

    # Do imputation for gestational diabetes
    print("Imputing for gestational diabetes...")

    data_only_gestational_diabetes <- data %>% filter(Gestational.Diabetes == 1)
    print("Participants with gestational diabetes: ")
    print(nrow(data_only_gestational_diabetes))


    impute_survey_data(data_to_drop_cols_from=data_only_gestational_diabetes, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_gestational_diabetes"),
                                    view_predictors_matrix = view_predictors_matrix)




    # Do imputation for diabetics type 1
    print("Imputing for diabetics type 1...")

    data_only_diabetes1 <- data %>% filter(Diabetes1 == 1)
    print("Participants with diabetes type 1: ")
    print(nrow(data_only_diabetes1))


    impute_survey_data(data_to_drop_cols_from=data_only_diabetes1, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_diabetes1"),
                                    view_predictors_matrix = view_predictors_matrix)

    # Do imputation for diabetics type 2
    print("Imputing for diabetics type 2...")

    data_only_diabetes2 <- data %>% filter(Diabetes2 == 1)
    print("Participants with diabetes type 2: ")
    print(nrow(data_only_diabetes2))


    impute_survey_data(data_to_drop_cols_from=data_only_diabetes2, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_diabetes2"),
                                    view_predictors_matrix = view_predictors_matrix)





    #Load data
    data_only_prediabetics <- data %>% filter(Prediabetes == 1)
    # Do imputation for prediabetics
    print("Imputing for prediabetics...")
    print("Participants with prediabetes: ")
    print(nrow(data_only_prediabetics))


    impute_survey_data(data_to_drop_cols_from=data_only_prediabetics, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_prediabetics"),
                                    view_predictors_matrix = view_predictors_matrix)



    #Load data
    data_only_BMI_over_30 <- data %>% filter(BMI > 30)
    # Do imputation for BMI_over_30
    print("Imputing for BMI_over_30")
    print("Participants with BMI_over_30: ")
    print(nrow(data_only_BMI_over_30))


    impute_survey_data(data_to_drop_cols_from=data_only_BMI_over_30, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_BMI_over_30"),
                                    view_predictors_matrix = view_predictors_matrix)




    #Load data
    data_only_healthy <- data %>% filter(Prediabetes == 0 & Diabetes2 == 0  & Diabetes1 == 0  & Gestational.Diabetes == 0 & BMI < 30)
    # Do imputation for non-diabetics non prediabetics 
    print("Imputing for participants without diabetes1 or diabetes2, gestational diabetes or prediabetes")
    print("Participants without diabetes1 or diabetes2, gestational diabetes or prediabetes: ")
    print(nrow(data_only_healthy))

    impute_survey_data(data_to_drop_cols_from=data_only_healthy, surveyVersion =surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_healthy(diabeteswise)"),
                                    view_predictors_matrix = view_predictors_matrix)


  
    #Load data
    data_only_insulin_resistant_groups <- data %>% filter(Prediabetes == 1 | Diabetes2 == 1 | Gestational.Diabetes == 1 | BMI >= 30)
    # Do imputation for non-diabetics non prediabetics 
    print("Imputing for insulin_resistant_groups...")
    print("Participants with diabetes2, gestational diabetes, prediabetes or BMI>30: ")
    print(nrow(data_only_insulin_resistant_groups))

    impute_survey_data(data_to_drop_cols_from=data_only_insulin_resistant_groups, surveyVersion =surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_insulin_resistant_groups"),
                                    view_predictors_matrix = view_predictors_matrix)

  
    #Load data
    data_only_non_insulin_resistant_groups <- data %>% filter(Prediabetes == 0 & Diabetes2 == 0  & Gestational.Diabetes == 0 & BMI < 30)
    # Do imputation for non-diabetics non prediabetics 
    print("Imputing for non_insulin_resistant_groups...")
    print("Participants without diabetes2, gestational diabetes, prediabetes or BMI<30: ")
    print(nrow(data_only_non_insulin_resistant_groups))

    impute_survey_data(data_to_drop_cols_from=data_only_non_insulin_resistant_groups, surveyVersion =surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                    amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                    cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                    cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                    savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_non_insulin_resistant_groups"),
                                    view_predictors_matrix = view_predictors_matrix)

}


# Do age-wise imputation
print("Imputing for age groups...")

#Load data
# Calculate the median age
median_age <- median(data$Decimal.Chronological.Age, na.rm = TRUE)
print(paste("median:", median_age))

# Split the data into two data frames
data_lower <- data[data$Decimal.Chronological.Age < median_age, ]
data_upper <- data[data$Decimal.Chronological.Age >= median_age, ]


#Run imputation for older group
impute_survey_data(data_to_drop_cols_from=data_upper, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_older"),
                                 view_predictors_matrix = view_predictors_matrix)

#Run imputation for younger group
impute_survey_data(data_to_drop_cols_from=data_lower, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_younger"),
                                 view_predictors_matrix = view_predictors_matrix)




### Impute - only females


#Load data
# Remove males from data
data_only_females <- data %>% filter(Biological.Sex == "Female")

print("Imputing for females")
print("Number of females")
print(nrow(data_only_females))


impute_survey_data(data_to_drop_cols_from=data_only_females, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_females"),
                                 view_predictors_matrix = view_predictors_matrix)




### Impute survey 1 - only males



#Load data
# Remove females from data
data_only_males <- data %>% filter(Biological.Sex == "Male")

print("Imputing for males")
print("Number of males:")
print(nrow(data_only_males))


impute_survey_data(data_to_drop_cols_from=data_only_males, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_males"),
                                 view_predictors_matrix = view_predictors_matrix)



### Impute survey 1 - only european
#Load data
# Remove females from data
print("Imputing for European")
data_only_european <-  data %>% filter(Ethnicity_reduced == "European")
print("Number of European:")
print(nrow(data_only_european))


impute_survey_data(data_to_drop_cols_from=data_only_european, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_european"),
                                 view_predictors_matrix = view_predictors_matrix)


### Impute survey 1 - only asian
#Load data
# Remove females from data
print("Imputing for asian")
data_only_asian <-  data %>% filter(Ethnicity_reduced == "Asian")
print("Number of asian:")
print(nrow(data_only_asian))


impute_survey_data(data_to_drop_cols_from=data_only_asian, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_asian"),
                                 view_predictors_matrix = view_predictors_matrix)


### Impute survey 1 - only other
#Load data
# Remove females from data
print("Imputing for other")
data_only_other <-  data %>% filter(Ethnicity_reduced == "Other")
print("Number of other:")
print(nrow(data_only_other))


impute_survey_data(data_to_drop_cols_from=data_only_other, surveyVersion = surv_number, missing_threshold = max_NA_percent_to_remove_cols_NON_main_models, 
                                 amount_of_mice_datasets_to_impute = number_of_mice_datasets_to_impute, max_iterations_per_dataset = maximum_iterations_per_dataset, 
                                 cols_to_exclude_from_imputation_entirely = cols_to_exclude, 
                                 cols_to_exclude_from_predictors = cols_to_exclude_from_predictors,
                                 savePath = paste0(path_to_data, "imputation_results/imputed_survey", surv_number,"_only_other"),
                                 view_predictors_matrix = view_predictors_matrix)





  print(paste0("Imputation results for survey: ", surv_number, " saved to ", path_to_data))
}

