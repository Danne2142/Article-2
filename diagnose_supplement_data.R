# Diagnostic script to check data and column availability
# This script helps diagnose why the supplement histogram isn't working

library(pacman)
p_load(dplyr, ggplot2)

# Check if data file exists
data_path <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Data/EPICv1 and v2 data/All_metrics_crossectional_samples.csv"

if(file.exists(data_path)) {
  cat("Data file found at:", data_path, "\n")
  
  # Load the data
  df <- read.csv(data_path, header = TRUE, stringsAsFactors = FALSE)
  cat("Data loaded. Dimensions:", nrow(df), "rows,", ncol(df), "columns\n\n")
  
  # Check for survey version column
  if("survey_version" %in% colnames(df)) {
    cat("Survey version column found!\n")
    print(table(df$survey_version, useNA = "ifany"))
  } else {
    cat("Survey version column NOT found.\n")
    cat("Looking for potential survey-identifying columns...\n")
    
    cols_survey2_3 <- c("Hours.Sedentary.Remaining.Awake", "Primary.Diet.Past.Year", 
                       "Feel.Well.Rested.days.per.week")
    cols_survey3_1 <- c("Height.in", "Weight", "Anti.Aging.Interventions", "Hours.of.sleep.per.night")
    
    found_survey_cols <- c()
    for(col in c(cols_survey2_3, cols_survey3_1)) {
      if(col %in% colnames(df)) {
        found_survey_cols <- c(found_survey_cols, col)
        cat("Found survey column:", col, "\n")
      }
    }
    
    if(length(found_survey_cols) == 0) {
      cat("No survey-identifying columns found.\n")
    }
  }
  
  cat("\nChecking for supplement columns...\n")
  
  # Original supplement list
  supplements_drugs <- c("NAD", "TA65", "sulforaphane", "DHEA_new", "Rapamycin_new", 
                        "SASP_supressors", "Metformin_new", "Resveratrol_new", 
                        "Exosomes", "stem_cells", "HRT", "spermidine", 
                        "semaglutide", "vitaminD", "AKG")
  
  found_supplements <- supplements_drugs[supplements_drugs %in% colnames(df)]
  cat("Found supplement columns:", paste(found_supplements, collapse = ", "), "\n")
  
  if(length(found_supplements) == 0) {
    cat("No exact supplement column matches found.\n")
    cat("Searching for partial matches...\n")
    
    # Look for partial matches
    all_cols <- colnames(df)
    supplement_patterns <- c("Metformin", "NAD", "TA", "sulforaphane", "DHEA", "Rapamycin", 
                           "SASP", "Resveratrol", "HRT", "vitamin", "spermidine", "semaglutide")
    
    for(pattern in supplement_patterns) {
      matching_cols <- all_cols[grepl(pattern, all_cols, ignore.case = TRUE)]
      if(length(matching_cols) > 0) {
        cat(paste("Columns matching", pattern, ":", paste(matching_cols, collapse = ", "), "\n"))
      }
    }
  } else {
    cat("\nChecking data in found supplement columns:\n")
    for(supp in found_supplements[1:min(3, length(found_supplements))]) {
      if(supp %in% colnames(df)) {
        true_count <- sum(df[[supp]] == TRUE, na.rm = TRUE)
        total_non_na <- sum(!is.na(df[[supp]]))
        cat(paste(supp, "- TRUE values:", true_count, "out of", total_non_na, "non-NA values\n"))
      }
    }
  }
  
  cat("\nFirst 10 column names:\n")
  print(head(colnames(df), 10))
  
  cat("\nColumns containing 'Anti' or 'Aging':\n")
  anti_aging_cols <- colnames(df)[grepl("Anti|Aging", colnames(df), ignore.case = TRUE)]
  print(anti_aging_cols)
  
  cat("\nColumns containing 'Supplement' or 'Medication':\n")
  supp_med_cols <- colnames(df)[grepl("Supplement|Medication", colnames(df), ignore.case = TRUE)]
  print(supp_med_cols)
  
} else {
  cat("Data file NOT found at:", data_path, "\n")
  cat("Please check the file path.\n")
  
  # List what files are in the expected directory
  data_dir <- dirname(data_path)
  if(dir.exists(data_dir)) {
    cat("Files in data directory:\n")
    print(list.files(data_dir, pattern = "*.csv"))
  } else {
    cat("Data directory does not exist:", data_dir, "\n")
  }
}

cat("\nDiagnostic complete.\n")
