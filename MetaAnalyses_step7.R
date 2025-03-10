
# Model 1
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe

# Run MetaAnalyse
Model1_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", model_no = 1)

