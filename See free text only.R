# Ladda nödvändiga bibliotek
library(readr)
library(dplyr)

# Import the CSV file into a dataframe named df_crossectional
df_crossectional <- read.csv("C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/df_EPICv1_old_with_all_collumns.csv", header=TRUE, stringsAsFactors=FALSE)

# Välj de specifika kolumnerna för att skapa df_clean
df <- df_crossectional %>%
  select(Patient.ID, Decimal.Chronological.Age, Resveratrol, Antiaging.Stem.Cell, Antiaging.Hormone.Replacement, Antiaging.Senolytics, Antiaging.NAD, NR.NAD, Supplements.Medication, Anti.Aging.Interventions)


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
remove_list <- c("Exosome therapy", "Stem cell therapy", "Hormone replacement therapy", "NAD therapy", "Senolytic therapy (dasatinib, quercetin, rapamycin, etc.)")
# Apply the function to the text_column of the data frame
df$Anti.Aging.Interventions <- remove_strings(df$Anti.Aging.Interventions, remove_list)

remove_list <- c("Digestive support: probiotic, digestive enzymes, etc.", "Herbal supplements", "Vitamins", "Fish oil/Omega fatty acids",
                 "Antioxidants: coenzyme Q10, green tree extract, resveratrol, etc.", "Workout supplements", "TA-65, cycloastragenol, astragalus",
                 "Sulforaphane, broccoli extract", "Minerals, calcium, iron, etc.", "Nicotinamide riboside (NR), Nicotinamide adenine dinucleotide (NAD), etc.",
                 "Nicotinamide ribose (NR), Nicotinamide adenine dinucleotide (NAD), etc.",
                 "Antioxidants: coenzyme Q10, green tea extract, resveratrol, etc.", "Resveratrol", "Metformin", "Rapamycin")



# Apply the function to the text_column of the data frame
df$Supplements.Medication <- remove_strings(df$Supplements.Medication, remove_list)

