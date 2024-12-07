# Ladda nödvändiga bibliotek
library(readr)
library(dplyr)

# Import the CSV file into a dataframe named df
df <- read.csv("C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/df_EPICv1_old_with_all_collumns.csv", header=TRUE, stringsAsFactors=FALSE)

# Function to remove specified strings from a column
remove_strings <- function(column, strings_to_remove) {
  # Use gsub to replace each string with an empty string
  for (str in strings_to_remove) {
    column <- gsub(str, "", column, fixed = TRUE)
  }
  # Remove extra spaces
  column <- gsub("\\s+", " ", column)
  column <- trimws(column)
  return(column)
}

# List of strings to remove
remove_list <- c("Digestive support: probiotic, digestive enzymes, etc.", "Herbal supplements", "Fish oil/Omega fatty acids",
                 "Antioxidants: coenzyme Q10, green tree extract, resveratrol, etc.", "Workout supplements",
                 "Minerals, calcium, iron, etc.", "Antioxidants: coenzyme Q10, green tea extract, resveratrol, etc.")

# Apply the function to the text_column of the data frame
df$Anti.Aging.Interventions <- remove_strings(df$Anti.Aging.Interventions, remove_list)
df$Supplements.Medication <- remove_strings(df$Supplements.Medication, remove_list)
df$Nutritional.Supplements <- remove_strings(df$Nutritional.Supplements, remove_list)

