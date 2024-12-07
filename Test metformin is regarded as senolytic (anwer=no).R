#Checks how many regard metformin as senolytic in EPICv1

# Ladda nödvändiga bibliotek
library(readr)
library(dplyr)

# Import the CSV file into a dataframe named df_crossectional
df_crossectional <- read.csv("C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/EPICv1.csv", header=TRUE, stringsAsFactors=FALSE)


# Välj de specifika kolumnerna för att skapa df_clean
df_clean1 <- df_crossectional %>%
  select(Patient.ID, PID, Array, Metformin, Antiaging.Senolytics, Nutritional.Supplements, Supplements.Medication, Anti.Aging.Interventions)


# Lägg till en ny kolumn Metformin_and_senolytic med standardvärdet FALSE
df_clean1 <- df_clean1 %>%
  mutate(Metformin_and_senolytic = FALSE)


# Uppdatera Metformin_and_senolytic kolumnen baserat på innehållet i Nutritional.Supplements, Supplements.Medication och Metformin
df_clean2 <- df_clean1 %>%
  mutate(Metformin_and_senolytic = ifelse(
    grepl("Metformin|Senolytic", Nutritional.Supplements, ignore.case = TRUE) |
      grepl("Metformin|Senolytic", Supplements.Medication, ignore.case = TRUE) |
      grepl("Metformin|Senolytic", Anti.Aging.Interventions, ignore.case = TRUE) |
      Antiaging.Senolytics == TRUE|
      Metformin == TRUE, 
    TRUE, 
    Metformin_and_senolytic
  ))

# Ta bort kolumnerna Metformin, Nutritional.Supplements och Supplements.Medication
df_clean <- df_clean2 %>%
  select(-Metformin, -Nutritional.Supplements, -Supplements.Medication, -Anti.Aging.Interventions)

# Ersätt alla NA-värden i Metformin_and_senolytic med FALSE
df_clean <- df_clean %>%
  mutate(Metformin_and_senolytic = ifelse(is.na(Metformin_and_senolytic), FALSE, Metformin_and_senolytic))

# Byt namn på kolumnen DHEA till DHEA_old
df_clean <- df_clean %>%
  rename(Metformin = Metformin_and_senolytic)

# Visa antal användare i varje kategori av Metformin_and_senolytic
frequency_table <- table(df_clean$Metformin)
print(frequency_table)

