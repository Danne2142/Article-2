library(pacman)
p_load(dplyr)


# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/set_NA_percent_and_imp_cols().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/mixed_correlation_matrix().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/imputationFunctions.R")


# Data exploration can be removed later
# #Load data
# load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step4")
# # Rename dataframe in this new script
# data<-data_with_ageDev
# rm(data_with_ageDev) # Remove old dataframe

# print(colnames(data))


### Calculate corr matrix
  # Remove unnecessary columns
  # data4_without_cols <- subset(data4, select = -c(Hannum.PC, Horvath.PC, Telomere.Values.PC, GrimAge.PC, PhenoAge.PC,
  #                                        SystemsAge.Heart, SystemsAge.Hormone, SystemsAge.Blood, SystemsAge.Brain, 
  #                                        SystemsAge.Inflammation, SystemsAge.Immune, SystemsAge.Kidney, SystemsAge.Liver,
  #                                        SystemsAge.Metabolic, SystemsAge.Lung, SystemsAge.MusculoSkeletal, SystemsAge,
  #                                        OMICmAge, fasting, Main.Diet, NAD, TA65, sulforaphane, DHEA_new, Rapamycin_new,
  #                                        SASP_supressors, Metformin_new, Resveratrol_new, Exosomes, stem_cells, HRT, 
  #                                        spermidine, semaglutide, vitaminD, AKG, Hannum.PCAgeDev, Horvath.PCAgeDev, 
  #                                         GrimAge.PCAgeDev, PhenoAge.PCAgeDev, OMICmAgeAgeDev,
  #                                        SystemsAge.BloodAgeDev, SystemsAge.BrainAgeDev, SystemsAge.InflammationAgeDev,
  #                                        SystemsAge.HeartAgeDev, SystemsAge.HormoneAgeDev, SystemsAge.ImmuneAgeDev,
  #                                        SystemsAge.KidneyAgeDev, SystemsAge.LiverAgeDev, SystemsAge.MetabolicAgeDev,
  #                                        SystemsAge.LungAgeDev, SystemsAge.MusculoSkeletalAgeDev, SystemsAgeAgeDev, DunedinPACE))

# OMICage och grimage är ej korrolerade över 0,8
# 
# Kolla OMICage-dunedin och dunedin-grimAge

# corr_df<-mixed_correlation_matrix(data4, cols_to_skip = c("Patient.ID", "PID", "Collection.Date", "Array", "survey_version"))

impute_survey_and_sensitivity_analysis(
  path_to_data="C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
  cols_to_exclude = c("Alcohol.per.week", "Level.of.Education", "Hours.of.sleep.per.night",
  "Tobacco.Use", "Exercise.per.week", "Drug.Alcohol.mother", "Drug.Alcohol.father", "Mother.Nicotine.Use", 
  "Mother.Pregnancy.Complications", "Caffeine.Use", "Marital.Status", "Sexual.Frequency"),
  surv_number = 1,
  missing_threshold_to_remove = 50,
  number_of_mice_datasets_to_impute = 2,
  maximum_iterations_per_dataset = 1
  )