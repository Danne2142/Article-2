
# Load functions
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_metaAnalysis().R")


# Initialize a dataframe to store results
meta_model1_z_results_df <- data.frame(
Outcome      = character(),
Term         = character(),
I2           = numeric(),
pval_Q       = numeric(),
Estimate    = numeric(),
lower_CI = numeric(),
upper_CI = numeric(),
effects  = character(),
stringsAsFactors = FALSE)

meta_model2_z_results_df <- data.frame(
Outcome      = character(),
Term         = character(),
I2           = numeric(),
pval_Q       = numeric(),
Estimate    = numeric(),
lower_CI = numeric(),
upper_CI = numeric(),
effects  = character(),
stringsAsFactors = FALSE)

meta_model3_z_results_df <- data.frame(
Outcome      = character(),
Term         = character(),
I2           = numeric(),
pval_Q       = numeric(),
Estimate    = numeric(),
lower_CI = numeric(),
upper_CI = numeric(),
effects  = character(),
stringsAsFactors = FALSE)



#DunedinPACE
# Model 1 SD
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_z_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model1_z
rm(DunedinPACE_Model1_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_z_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model1_z
rm(DunedinPACE_Model1_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_z_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model1_z
rm(DunedinPACE_Model1_z) # Remove old dataframe

# Run MetaAnalyse
Model1_z_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_1_z", savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")



# Model 2 SD
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_z_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model2_z
rm(DunedinPACE_Model2_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_z_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model2_z
rm(DunedinPACE_Model2_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_z_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model2_z
rm(DunedinPACE_Model2_z) # Remove old dataframe

# Run MetaAnalyse
Model2_z_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_2_z", savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")



# Model 3 SD
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_z_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model3_z
rm(DunedinPACE_Model3_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_z_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model3_z
rm(DunedinPACE_Model3_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_z_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model3_z
rm(DunedinPACE_Model3_z) # Remove old dataframe

# Run MetaAnalyse
Model3_z_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_3_z", savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


# OMICmAGE
# Model 1 SD
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model1_z_main_survey1")
# Rename dataframe in this new script
imp_survey1<-OmicAge_Model1_z
rm(OmicAge_Model1_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model1_z_main_survey2")
# Rename dataframe in this new script
imp_survey2<-OmicAge_Model1_z
rm(OmicAge_Model1_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model1_z_main_survey3")
# Rename dataframe in this new script
imp_survey3<-OmicAge_Model1_z
rm(OmicAge_Model1_z) # Remove old dataframe

# Run MetaAnalyse
Model1_z_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_1_z", savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


# Model 2 SD
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model2_z_main_survey1")
# Rename dataframe in this new script
imp_survey1<-OmicAge_Model2_z
rm(OmicAge_Model2_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model2_z_main_survey2")
# Rename dataframe in this new script                                                       
imp_survey2<-OmicAge_Model2_z
rm(OmicAge_Model2_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model2_z_main_survey3")
# Rename dataframe in this new script
imp_survey3<-OmicAge_Model2_z
rm(OmicAge_Model2_z) # Remove old dataframe

# Run MetaAnalyse
Model2_z_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_2_z", savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


# Model 3 SD
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model3_z_main_survey1")
# Rename dataframe in this new script
imp_survey1<-OmicAge_Model3_z
rm(OmicAge_Model3_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model3_z_main_survey2")
# Rename dataframe in this new script
imp_survey2<-OmicAge_Model3_z
rm(OmicAge_Model3_z) # Remove old dataframe
#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OmicAge_Model3_z_main_survey3")
# Rename dataframe in this new script
imp_survey3<-OmicAge_Model3_z
rm(OmicAge_Model3_z) # Remove old dataframe

# Run MetaAnalyse
Model3_z_results<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_3_z", savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


