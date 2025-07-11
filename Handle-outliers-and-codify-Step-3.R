## -----------------------------------------------------------------------------
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/remove_other().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/logical_to_numeric().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_to_factors().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_yes_no_to_logical().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_to_binary().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/char_cols_to_factors().R")
# 

source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/count_outliers().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/get_Numeric_and_int_cols().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_with_std_outliers().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/replace_zero_negatives().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/count_zero_and_negatives().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/remove_na_rows().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/remove_outliers_sd().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/create_histogram().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/handle_hours_sedentary_remaining_awake().R")
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step2")

# Rename dataframe in this new script
data<-data_fixed_datatypes 
rm(data_fixed_datatypes) # Remove old dataframe



## -----------------------------------------------------------------------------
amount_zero_and_negatives_before_removal<-count_zero_and_negatives(data, exclude_cols=c("Patient.ID", "PID", "survey_version", "Array", 
                                                      "Collection.Date", "Decimal.Chronological.Age", 
                                                      "Stress.Level",  
                                                      "Age.mother.at.birth", "Age.father.at.birth", 
                                                      "Hours.Sedentary.Remaining.Awake", "BMI", 
                                                      "Hannum.PCAgeDev", "Horvath.PCAgeDev", 
                                                      "Telomere.Values.PCAgeDev", "GrimAge.PCAgeDev", 
                                                      "PhenoAge.PCAgeDev", "SystemsAge.BloodAgeDev", 
                                                      "SystemsAge.BrainAgeDev", "SystemsAge.InflammationAgeDev", 
                                                      "SystemsAge.HeartAgeDev", "SystemsAge.HormoneAgeDev", 
                                                      "SystemsAge.ImmuneAgeDev", "SystemsAge.KidneyAgeDev", 
                                                      "SystemsAge.LiverAgeDev", "SystemsAge.MetabolicAgeDev", 
                                                      "SystemsAge.LungAgeDev", "SystemsAge.MusculoSkeletalAgeDev", 
                                                      "SystemsAgeAgeDev", "OMICmAgeAgeDev"))


## -----------------------------------------------------------------------------
# Remove rows with zero, negative or NA values in outcome columns
data_with_outliers_removed <- replace_zero_negatives(data, cols=c("Hannum.PC", "Horvath.PC",
  "Telomere.Values.PC", "GrimAge.PC", "PhenoAge.PC", "SystemsAge.Blood",
  "SystemsAge.Brain", "SystemsAge.Inflammation", "SystemsAge.Heart",
  "SystemsAge.Hormone", "SystemsAge.Immune", "SystemsAge.Kidney",
  "SystemsAge.Liver", "SystemsAge.Metabolic", "SystemsAge.Lung",
  "SystemsAge.MusculoSkeletal", "SystemsAge", "OMICmAge", "DunedinPACE"))



## -----------------------------------------------------------------------------

amount_zero_and_negatives_after_removal<-count_zero_and_negatives(data_with_outliers_removed, exclude_cols=c("Patient.ID", "PID", "survey_version", "Array", 
                                                      "Collection.Date", "Decimal.Chronological.Age", 
                                                      "Stress.Level",  
                                                      "Age.mother.at.birth", "Age.father.at.birth", 
                                                      "Hours.Sedentary.Remaining.Awake", "BMI", 
                                                      "Hannum.PCAgeDev", "Horvath.PCAgeDev", 
                                                      "Telomere.Values.PCAgeDev", "GrimAge.PCAgeDev", 
                                                      "PhenoAge.PCAgeDev", "SystemsAge.BloodAgeDev", 
                                                      "SystemsAge.BrainAgeDev", "SystemsAge.InflammationAgeDev", 
                                                      "SystemsAge.HeartAgeDev", "SystemsAge.HormoneAgeDev", 
                                                      "SystemsAge.ImmuneAgeDev", "SystemsAge.KidneyAgeDev", 
                                                      "SystemsAge.LiverAgeDev", "SystemsAge.MetabolicAgeDev", 
                                                      "SystemsAge.LungAgeDev", "SystemsAge.MusculoSkeletalAgeDev", 
                                                      "SystemsAgeAgeDev", "OMICmAgeAgeDev"))



## -----------------------------------------------------------------------------


# Using dplyr and case_when
library(pacman)
p_load(dplyr)

data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(sedentary_level_objective = case_when(
    Hours.Sedentary.Remaining.Awake >= 1  & Hours.Sedentary.Remaining.Awake <= 6 ~ 3,
    Hours.Sedentary.Remaining.Awake >= 7  & Hours.Sedentary.Remaining.Awake <= 12 ~ 2,
    Hours.Sedentary.Remaining.Awake >= 13 & Hours.Sedentary.Remaining.Awake <= 18 ~ 1,
    Hours.Sedentary.Remaining.Awake >= 19 & Hours.Sedentary.Remaining.Awake <= 24 ~ 0,
    TRUE ~ NA_real_
  ))



## -----------------------------------------------------------------------------

# # Using names() with seq_along()
# column_names <- names(data_with_outliers_removed)
# column_indices <- seq_along(data_with_outliers_removed)
# 
# print(column_names)


## -----------------------------------------------------------------------------
data_with_outliers_removed <- handle_hours_sedentary_remaining_awake(
  data = data_with_outliers_removed,
  column_name = "Hours.Sedentary.Remaining.Awake"
)



## ----message=TRUE, warning=TRUE-----------------------------------------------
count_frequencies <- function(data, column_name) {
  # Ensure the column exists in the data frame
  if (!column_name %in% names(data)) {
    stop("The specified column does not exist in the data frame.")
  }
  
  # Count frequencies using table and convert to a data frame
  frequencies <- as.data.frame(table(data[[column_name]]))
  
  # Rename the columns for clarity
  colnames(frequencies) <- c("Value", "Frequency")
  
  return(frequencies)
}

#See uncodified sedentary level
# df <- data.frame(numbers = c(1, 2, 2, 3, 3, 3, 4))
result <- count_frequencies(data_with_outliers_removed, "Hours.Sedentary.Remaining.Awake")
print(result)

#Compare sedentary level based on quartiles
# df <- data.frame(numbers = c(1, 2, 2, 3, 3, 3, 4))
result <- count_frequencies(data_with_outliers_removed, "sedentary_level")
print(result)

#Compare sedentary level based on fixed thresholds
result <- count_frequencies(data_with_outliers_removed, "sedentary_level_objective")
print(result)



## -----------------------------------------------------------------------------
# Plot the scatter plot
# plot(data_with_outliers_removed$sedentary_level, data_with_outliers_removed$DunedinPACE, main = "Scatter Plot with Regression Line",
#      xlab = "X-axis", ylab = "Y-axis",
#      pch = 19, col = "blue")

# Add regression line
# abline(lm(data_with_outliers_removed$DunedinPACE ~ data_with_outliers_removed$sedentary_level), col = "red")

# lm(data_with_outliers_removed$DunedinPACE ~ data_with_outliers_removed$sedentary_level)



## -----------------------------------------------------------------------------
print(class(data_with_outliers_removed$Tobacco.Use))

# Convert the ordered factor to numeric, starting at zero, preserving NAs
data_with_outliers_removed$Tobacco.Use.Numeric <- ifelse(
  is.na(data_with_outliers_removed$Tobacco.Use),
  NA_real_,
  as.numeric(data_with_outliers_removed$Tobacco.Use) - 1
)

# Move the Tobacco.Use.Numeric column to the end
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Tobacco.Use.Numeric, .after = last_col())

print(class(data_with_outliers_removed$Tobacco.Use.Numeric))


## -----------------------------------------------------------------------------
p_load(dplyr)

# Create a new data frame with only the removed rows (BMI < 15 and not NA)
removed_low_BMI_rows <- data_with_outliers_removed %>%
  filter(BMI < 15 & !is.na(BMI))

# Create a new data frame with the remaining rows (BMI >= 15 or BMI is NA)
data_with_outliers_removed <- data_with_outliers_removed %>%
  filter(BMI >= 15 | is.na(BMI))


# Move the Tobacco.Use.Numeric column to the end
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(BMI, .after = last_col())
  
# Sort the data frame according to the BMI column for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(BMI)

# Check which rows where removed for testing
removed_low_BMI_rows <- removed_low_BMI_rows %>%
  relocate(BMI, .after = last_col())



## -----------------------------------------------------------------------------

# Define the mapping for the education levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Education_levels_numeric = case_when(
    Level.of.Education == "Did not complete high school" ~ 0,
    Level.of.Education == "High school or equivalent" ~ 1,
    Level.of.Education %in% c("Technical or occupational certificate", "Associate degree", "Some college coursework completed") ~ 2,
    Level.of.Education == "Bachelor’s degree" ~ 3,
    Level.of.Education %in% c("Master’s degree", "Doctorate (PhD)", "Professional (MD, DO, DDS, JD)") ~ 4,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))

# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Level.of.Education, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Education_levels_numeric)


## -----------------------------------------------------------------------------
unique(data_with_outliers_removed$Alcohol.per.week)

# Load the dplyr package
p_load(dplyr)

# Define the mapping for the alcohol consumption levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Alcohol_per_week_numeric = case_when(
    Alcohol.per.week == "Never" ~ 0,
    Alcohol.per.week == "On special occasions" ~ 1,
    Alcohol.per.week == "Once per week" ~ 2,
    Alcohol.per.week == "3-5 times per week" ~ 3,
    Alcohol.per.week == "Regularly" ~ 4,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))
# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Alcohol.per.week, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Alcohol_per_week_numeric)



## -----------------------------------------------------------------------------
unique(data_with_outliers_removed$Exercise.per.week)

# Load the dplyr package
p_load(dplyr)

# Define the mapping for the Exercise.per.week levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Exercise.per.week_numeric = case_when(
    Exercise.per.week == "Never" ~ 0,
    Exercise.per.week == "1-2 times per week" ~ 1,
    Exercise.per.week == "3-4 times per week" ~ 2,
    Exercise.per.week == "5-7 times per week" ~ 3,
    Exercise.per.week == "8 or more times per week" ~ 4,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))
# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Exercise.per.week, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Exercise.per.week_numeric)



## -----------------------------------------------------------------------------
unique(data_with_outliers_removed$Caffeine.Use)

# Load the dplyr package
p_load(dplyr)

# Define the mapping for the Caffeine.Use consumption levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Caffeine.Use_numeric = case_when(
    Caffeine.Use == "Never" ~ 0,
    Caffeine.Use == "On special occasions" ~ 1,
    Caffeine.Use == "Once per week" ~ 2,
    Caffeine.Use == "Regularly" ~ 3,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))
# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Caffeine.Use, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Caffeine.Use_numeric)



## -----------------------------------------------------------------------------
unique(data_with_outliers_removed$Sexual.Frequency)

# Load the dplyr package
p_load(dplyr)

# Define the mapping for the Caffeine.Use consumption levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Sexual.Frequency_numeric = case_when(
    Sexual.Frequency == "Inactive" ~ 0,
    Sexual.Frequency == "Occasionally" ~ 1,
    Sexual.Frequency == "Regularly" ~ 2,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))
# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Sexual.Frequency, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Sexual.Frequency_numeric)



## -----------------------------------------------------------------------------
unique(data_with_outliers_removed$Marital.Status)

# Load the dplyr package
p_load(dplyr)

# Define the mapping for the Caffeine.Use consumption levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Marital.Status_numeric = case_when(
    Marital.Status == "Single" ~ 0,
    Marital.Status == "Divorced" ~ 0,
    Marital.Status == "Widowed" ~ 0,
    Marital.Status == "Separated" ~ 0,
    Marital.Status == "Partner" ~ 1,
    Marital.Status == "Married" ~ 2,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))
  
# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Marital.Status, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Marital.Status_numeric)




## -----------------------------------------------------------------------------
unique(data_with_outliers_removed$Hours.of.sleep.per.night)

# Load the dplyr package
p_load(dplyr)

# Define the mapping for the Caffeine.Use consumption levels
data_with_outliers_removed <- data_with_outliers_removed %>%
  mutate(Hours.of.sleep.per.night_numeric = case_when(
    Hours.of.sleep.per.night == "6 hours or less" ~ 0,
    Hours.of.sleep.per.night == "6 to 8 hours" ~ 1,
    Hours.of.sleep.per.night == "More than 8 hours" ~ 2,
    TRUE ~ NA_real_  # Handles any other cases or NA values
  ))
  
# Check which rows where altered for testing
data_with_outliers_removed <- data_with_outliers_removed %>%
  relocate(Hours.of.sleep.per.night, .after = last_col())

# Sort for testing
  data_with_outliers_removed <- data_with_outliers_removed %>%
  arrange(Hours.of.sleep.per.night_numeric)




## -----------------------------------------------------------------------------
save(data_with_outliers_removed, file = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step3")



## -----------------------------------------------------------------------------
# Assuming your data frame is named df
colnames(data_with_outliers_removed)


## -----------------------------------------------------------------------------
# # Define the output directory
# output_dir <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/Visualization of outliers after removal"

# # Create the output directory if it doesn't exist
# if (!dir.exists(output_dir)) {
#   dir.create(output_dir, recursive = TRUE)
# }

# exclude_columns = c("Patient.ID", "PID", "survey_version", "Array", "Collection.Date")

# # Assuming you have a dataframe `data_with_outliers_removed`
# col_numbers <- get_Numeric_and_int_cols(data_with_outliers_removed, exclude_cols = exclude_columns)
# col_names <- names(data_with_outliers_removed)[col_numbers]

# for (col_name in col_names) {
#   # Define the file name for each plot
#   file_name <- paste0(output_dir, "/plot_col_", col_name, ".pdf")
  
#   # Open a PDF device
#   pdf(file_name)
  
#   # Generate the plot
#   plot_with_std_outliers(data_with_outliers_removed, outliers_std_thresh = 5, col_num = which(names(data_with_outliers_removed) == col_name))
  
#   # Close the PDF device
#   dev.off()
# }


