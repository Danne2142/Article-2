

# Load functions
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_metaAnalysis().R")




## DUNEDINPACE
# Model 1
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe

# Run MetaAnalyse
Model1_results_DunedinPACE<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_1", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")



# Model 2
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model2
rm(DunedinPACE_Model2) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model2
rm(DunedinPACE_Model2) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model2
rm(DunedinPACE_Model2) # Remove old dataframe

# Run MetaAnalyse
Model2_results_DunedinPACE<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_2", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


# Model 3
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_main_survey1")
# Rename dataframe in this new script
imp_survey1<-DunedinPACE_Model3
rm(DunedinPACE_Model3) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_main_survey2")
# Rename dataframe in this new script
imp_survey2<-DunedinPACE_Model3
rm(DunedinPACE_Model3) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_main_survey3")
# Rename dataframe in this new script
imp_survey3<-DunedinPACE_Model3
rm(DunedinPACE_Model3) # Remove old dataframe

# Run MetaAnalyse
Model3_results_DunedinPACE<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_3", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")





## OMICmAGE
# Model 1
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model1_main_survey1")
# Rename dataframe in this new script
imp_survey1<-OMICmAgeAgeDev_Model1
rm(OMICmAgeAgeDev_Model1) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model1_main_survey2")
# Rename dataframe in this new script
imp_survey2<-OMICmAgeAgeDev_Model1
rm(OMICmAgeAgeDev_Model1) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model1_main_survey3")
# Rename dataframe in this new script
imp_survey3<-OMICmAgeAgeDev_Model1
rm(OMICmAgeAgeDev_Model1) # Remove old dataframe

# Run MetaAnalyse
Model1_results_OMICmAge<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_1", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")



# Model 2
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model2_main_survey1")
# Rename dataframe in this new script
imp_survey1<-OMICmAgeAgeDev_Model2
rm(OMICmAgeAgeDev_Model2) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model2_main_survey2")
# Rename dataframe in this new script
imp_survey2<-OMICmAgeAgeDev_Model2
rm(OMICmAgeAgeDev_Model2) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model2_main_survey3")
# Rename dataframe in this new script
imp_survey3<-OMICmAgeAgeDev_Model2
rm(OMICmAgeAgeDev_Model2) # Remove old dataframe

# Run MetaAnalyse
Model2_results_OMICmAge<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_2", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


# Model 3
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model3_main_survey1")
# Rename dataframe in this new script
imp_survey1<-OMICmAgeAgeDev_Model3
rm(OMICmAgeAgeDev_Model3) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model3_main_survey2")
# Rename dataframe in this new script
imp_survey2<-OMICmAgeAgeDev_Model3
rm(OMICmAgeAgeDev_Model3) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model3_main_survey3")
# Rename dataframe in this new script
imp_survey3<-OMICmAgeAgeDev_Model3
rm(OmicAgOMICmAgeAgeDev_Model3e_Model3) # Remove old dataframe

# Run MetaAnalyse
Model3_results_OMICmAge<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_3", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")



## GrimAge
# Model 1
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model1_main_survey1")
# Rename dataframe in this new script
imp_survey1<-GrimAge_PCAgeDev_Model1
rm(GrimAge_PCAgeDev_Model1) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model1_main_survey2")
# Rename dataframe in this new script                       
imp_survey2<-GrimAge_PCAgeDev_Model1
rm(GrimAge_PCAgeDev_Model1) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model1_main_survey3")
# Rename dataframe in this new script
imp_survey3<-GrimAge_PCAgeDev_Model1
rm(GrimAge_PCAgeDev_Model1) # Remove old dataframe

# Run MetaAnalyse
Model1_results_GrimAge<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_1", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")



# Model 2
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model2_main_survey1")
# Rename dataframe in this new script
imp_survey1<-GrimAge_PCAgeDev_Model2
rm(GrimAge_PCAgeDev_Model2) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model2_main_survey2")
# Rename dataframe in this new script
imp_survey2<-GrimAge_PCAgeDev_Model2
rm(GrimAge_PCAgeDev_Model2) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model2_main_survey3")
# Rename dataframe in this new script                                                     
imp_survey3<-GrimAge_PCAgeDev_Model2
rm(GrimAge_PCAgeDev_Model2) # Remove old dataframe

# Run MetaAnalyse
Model2_results_GrimAge<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_2", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")


# Model 3
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model3_main_survey1")
# Rename dataframe in this new script
imp_survey1<-GrimAge_PCAgeDev_Model3
rm(GrimAge_PCAgeDev_Model3) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model3_main_survey2")
# Rename dataframe in this new script
imp_survey2<-GrimAge_PCAgeDev_Model3
rm(GrimAge_PCAgeDev_Model3) # Remove old dataframe
#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model3_main_survey3")
# Rename dataframe in this new script
imp_survey3<-GrimAge_PCAgeDev_Model3
rm(OmicAgGrimAge_PCAgeDev_Model3) # Remove old dataframe

# Run MetaAnalyse
Model3_results_GrimAge<-MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, model_name = "model_3", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")




#Plot
# plot_metaAnalysis(meta_df = Model1_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_1", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model2_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_2", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model3_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_3", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model1_z_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_1_z", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model2_z_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_2_z", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model3_z_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_3_z", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")plot_metaAnalysis(meta_df = Model1_z_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_1_z", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model2_z_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_2_z", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")
# plot_metaAnalysis(meta_df = Model3_z_results, xlabel = "Aging Pace (biological year/chronological year)", ylabel = "Term", vertical_line_value = 0, model_name = "model_3_z", savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/")