# Load necessary libraries
library(readr)
library(dplyr)

# Define the function
remove_unnecessary_strings <- function(df, strings_to_remove, columns_to_process) {

  # Function to remove specified strings from a column
  remove_strings <- function(column, strings_to_remove) {
    for (str in strings_to_remove) {
      column <- gsub(str, "", column, fixed = TRUE)
    }
    column <- gsub("\\s+", " ", column)
    column <- trimws(column)
    return(column)
  }
  
  # Apply the remove_strings function to the specified columns
  for (col in columns_to_process) {
    df[[col]] <- remove_strings(df[[col]], strings_to_remove)
  }
  
  # Return the modified dataframe
  return(df)
}
# 
# # Define the parameters
# remove_list <- c("Digestive support: probiotic, digestive enzymes, etc.", "Herbal supplements", "Fish oil/Omega fatty acids",
#                  "Antioxidants: coenzyme Q10, green tree extract, resveratrol, etc.", "Workout supplements",
#                  "Minerals, calcium, iron, etc.", "Antioxidants: coenzyme Q10, green tea extract, resveratrol, etc.")
# columns_to_process <- c("Anti.Aging.Interventions", "Supplements.Medication", "Nutritional.Supplements")
# 
# # Call the function and get the modified dataframe
# modified_df <- remove_unnecessary_strings(df, remove_list, columns_to_process)
