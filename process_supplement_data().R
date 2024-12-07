library(readr)
library(dplyr)

process_supplement_data <- function(
    file_path,          # Sökväg till CSV-filen
    supplement,         # Namn på tillskottet (t.ex., NAD)
    searchwords_case_unsensitive, # Sökkriterier som inte är känsliga för versaler/gemener
    searchwords_case_sensitive,   # Sökkriterier som är känsliga för versaler/gemener
    old_columns,         # Lista med gamla kolumner som ska beaktas
    rows_to_remove = c() # Lista med Patient.ID:s som kommer tas bort från processingen och sättas i outputen removed rows
) {

  
  # Importera CSV-filen i en dataframe
  df_crossectional <- read.csv(file_path, header=TRUE, stringsAsFactors=FALSE)
  
  # Välj de specifika kolumnerna för att skapa df_clean
  df_clean1 <- df_crossectional %>%
    select(Patient.ID, PID, Array, Collection.Date, all_of(old_columns), Supplements.Medication, Anti.Aging.Interventions)
  
  df_removed_rows <- df_clean1 %>% filter(Patient.ID %in% rows_to_remove) # keep the rows where Patient.ID is in the rows_to_remove list.
  
  df_clean1 <- df_clean1 %>% filter(!(Patient.ID %in% rows_to_remove)) #The ! negates the condition, so it keeps the rows where Patient.ID is not in the rows_to_remove list.
  
  # Skapa en logisk vektor som visar om något av sökorden finns i de relevanta kolumnerna
  condition_unsensitive <- grepl(searchwords_case_unsensitive, df_clean1$Supplements.Medication, ignore.case = TRUE) |
    grepl(searchwords_case_unsensitive, df_clean1$Anti.Aging.Interventions, ignore.case = TRUE)
  
  # Om searchwords_case_sensitive inte är en tom sträng, utför sökning, annars skapa en logisk vektor med FALSE
  if (searchwords_case_sensitive != "") {
    condition_sensitive <- grepl(searchwords_case_sensitive, df_clean1$Supplements.Medication, ignore.case = FALSE) |
      grepl(searchwords_case_sensitive, df_clean1$Anti.Aging.Interventions, ignore.case = FALSE)
  } else {
    condition_sensitive <- rep(FALSE, nrow(df_clean1))
  }
  
  condition_old_columns <- rowSums(df_clean1[old_columns] == TRUE, na.rm = TRUE) > 0
  
  # Uppdatera den nya kolumnen baserat på logiska vektorer
  df_clean1 <- df_clean1 %>%
    mutate(!!sym(supplement) := condition_unsensitive | condition_sensitive | condition_old_columns)
  
  # Skapa df_searchword_findings med de rader som uppfyller sökkriterierna och har minst en TRUE i old_columns
  df_searchword_findings <- df_clean1 %>%
    filter(!!sym(supplement) == TRUE & condition_old_columns == FALSE)
  
  # Ta bort gamla kolumner och specifika kolumner
  df_clean <- df_clean1 %>%
    select(-all_of(old_columns), -Supplements.Medication, -Anti.Aging.Interventions)
  
  
  # Returnera df_clean1, df_clean och df_searchword_findings
  return(list(df_clean1 = df_clean1, df_clean = df_clean, searchword_findings = df_searchword_findings, df_removed_rows = df_removed_rows))
}

# result <- process_supplement_data(
#   file_path = "C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/df_EPICv1_old_with_all_collumns.csv",
#   supplement = "Spermidine",
#   searchwords_case_unsensitive = "Spermidine|Primeadine|Spermedine",
#   searchwords_case_sensitive = "",
#   old_columns = c(),
#   rows_to_remove = c("207179240111_R03C01")
# )
# 
# # 
# # Åtkomst till df_clean1 och df_clean från resultatet
# df_clean1 <- result$df_clean1
# df_clean <- result$df_clean
# searchword_findings<- result$searchword_findings
# df_removed_rows<-result$df_removed_rows
# sum(df_clean$Spermidine)
