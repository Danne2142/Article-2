## -----------------------------------------------------------------------------
library(dplyr)

# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/remove_other().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/logical_to_numeric().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_to_factors().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_yes_no_to_logical().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_to_binary().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/char_cols_to_factors().R")
# 
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/calc_AgeDev().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/z_transform().R")

source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/count_outliers().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/get_Numeric_and_int_cols().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_with_std_outliers().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/replace_zero_negatives().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/count_zero_and_negatives().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/replace_zero_negatives().R")


load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step3")
# Rename dataframe in this new script
data<-data_with_outliers_removed
rm(data_with_outliers_removed) # Remove old dataframe


## -----------------------------------------------------------------------------
data_with_ageDev<-data
biological_age_markers <- c("Hannum.PC","Horvath.PC",
                  "GrimAge.PC","PhenoAge.PC","OMICmAge","SystemsAge.Blood","SystemsAge.Brain","SystemsAge.Inflammation",
                  "SystemsAge.Heart","SystemsAge.Hormone","SystemsAge.Immune","SystemsAge.Kidney","SystemsAge.Liver","SystemsAge.Metabolic",
                  "SystemsAge.Lung","SystemsAge.MusculoSkeletal","SystemsAge")
for (variable in biological_age_markers) {
data_with_ageDev<- calc_AgeDev(data_with_ageDev, variable)
}



## -----------------------------------------------------------------------------
z_transform <- function(df, col_name) {
  # Check if the column exists in the data frame
  if (!col_name %in% names(df)) {
    stop("Column not found in the data frame.")
  }
  
  # Extract the column data
  col_data <- df[[col_name]]
  
  # Verify that the column is numeric
  if (!is.numeric(col_data)) {
    stop("Column must be numeric for z-transformation.")
  }
  
  # Calculate the z-score (subtract mean and divide by standard deviation)
  z <- (col_data - mean(col_data, na.rm = TRUE)) / sd(col_data, na.rm = TRUE)
  
  # Append the z-transformed column to the data frame
  df[[paste0(col_name, "_z")]] <- z
  
  return(df)
}
# Apply z-transform and relocate for each AgeDev biomarker column
for (variable in biological_age_markers) {
  ageDev_col <- paste0(variable, "AgeDev")
  
  # Check if the column exists, then apply z_transform
  if (ageDev_col %in% names(data_with_ageDev)) {
    data_with_ageDev <- z_transform(data_with_ageDev, ageDev_col)
    
    # Move the original AgeDev column to the end of the dataframe
    data_with_ageDev <- data_with_ageDev %>%
      relocate(!!rlang::sym(ageDev_col), .after = last_col())
  } else {
    warning(paste("Column", ageDev_col, "not found in the data frame."))
  }
}

data_with_ageDev <- z_transform(data_with_ageDev, "DunedinPACE")
data_with_ageDev <- data_with_ageDev %>%
  relocate(DunedinPACE, .after = last_col())


## -----------------------------------------------------------------------------
# col_numbers<- get_Numeric_and_int_cols(data_with_ageDev, exclude_cols= c("Patient.ID", "PID", "survey_version", "Array", "Collection.Date", "Decimal.Chronological.Age", "Hannum.PC", "Horvath.PC",
#   "Telomere.Values.PC", "GrimAge.PC", "PhenoAge.PC", "SystemsAge.Blood",
#   "SystemsAge.Brain", "SystemsAge.Inflammation", "SystemsAge.Heart",
#   "SystemsAge.Hormone", "SystemsAge.Immune", "SystemsAge.Kidney",
#   "SystemsAge.Liver", "SystemsAge.Metabolic", "SystemsAge.Lung",
#   "SystemsAge.MusculoSkeletal", "SystemsAge", "OMICmAge", "DunedinPACE"))

# for (i in col_numbers) {

#   plot_with_std_outliers(data_with_ageDev, outliers_std_thresh = 5, col_num = i)

# }



## -----------------------------------------------------------------------------
save(data_with_ageDev, file = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step4")


