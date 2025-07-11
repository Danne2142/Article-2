# load(paste0("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", "data_after_step4"))
# data<-data_with_ageDev

# # Calculate the median age
# median_age <- median(data$Decimal.Chronological.Age, na.rm = TRUE)
# print(paste("median:", median_age))

# # Split the data into two data frames
# data_lower <- data[data$Decimal.Chronological.Age < median_age, ]
# data_upper <- data[data$Decimal.Chronological.Age >= median_age, ]


library(pacman)
p_load(dplyr)
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/set_NA_percent_and_imp_cols().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/mixed_correlation_matrix().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/imputationFunctions.R")


# ## Data exploration can be removed later
# # Load data
# # load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step4")
# # # Rename dataframe in this new script
# # data<-data_with_ageDev
# # rm(data_with_ageDev) # Remove old dataframe

# # print(colnames(data))


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



#Impute survey 1 and sensitivity analysis
impute_survey_and_sensitivity_analysis(
  path_to_data="C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
  cols_to_exclude = c("Alcohol.per.week", "Level.of.Education", "Hours.of.sleep.per.night", #Because these variables have been converted to numbers, harmonized to fewer categories (like diet), or regardet as superfluous (sexual frequency) (see step3)
  "Tobacco.Use", "Exercise.per.week", "Caffeine.Use", "Marital.Status", "Sexual.Frequency", "Main.Diet", "Main.Diet.Factor"),
  surv_number = 1,
  max_NA_percent_to_remove_cols_main_models = 30,
  max_NA_percent_to_remove_cols_NON_main_models = 50,
  number_of_mice_datasets_to_impute = 5,
  maximum_iterations_per_dataset = 5,
  cols_to_exclude_from_predictors= c("Patient.ID", "PID", "Collection.Date", "Array", "survey_version", "OMICmAgeAgeDev", "GrimAge.PCAgeDev", "Hannum.PCAgeDev", "Horvath.PCAgeDev",
                                                        "PhenoAge.PCAgeDev", "SystemsAge.BloodAgeDev",
                                                        "SystemsAge.BrainAgeDev", "SystemsAge.InflammationAgeDev",
                                                        "SystemsAge.HeartAgeDev", "SystemsAge.HormoneAgeDev",
                                                        "SystemsAge.ImmuneAgeDev", "SystemsAge.KidneyAgeDev",
                                                        "SystemsAge.LiverAgeDev", "SystemsAge.MetabolicAgeDev",
                                                        "SystemsAge.LungAgeDev", "SystemsAge.MusculoSkeletalAgeDev",
                                                        "SystemsAgeAgeDev", "OMICmAge", "GrimAge.PC","Hannum.PC", "Horvath.PC",
    "Telomere.Values.PC", "PhenoAge.PC", "SystemsAge.Blood",
    "SystemsAge.Brain", "SystemsAge.Inflammation", "SystemsAge.Heart",
    "SystemsAge.Hormone", "SystemsAge.Immune", "SystemsAge.Kidney",
    "SystemsAge.Liver", "SystemsAge.Metabolic", "SystemsAge.Lung",
    "SystemsAge.MusculoSkeletal", "SystemsAge", "DunedinPACE", "OMICmAgeAgeDev_z", "GrimAge.PCAgeDev_z", "Hannum.PCAgeDev_z", "Horvath.PCAgeDev_z",
"PhenoAge.PCAgeDev_z", "SystemsAge.BloodAgeDev_z",
"SystemsAge.BrainAgeDev_z", "SystemsAge.InflammationAgeDev_z",
"SystemsAge.HeartAgeDev_z", "SystemsAge.HormoneAgeDev_z",
"SystemsAge.ImmuneAgeDev_z", "SystemsAge.KidneyAgeDev_z",
"SystemsAge.LiverAgeDev_z", "SystemsAge.MetabolicAgeDev_z",
"SystemsAge.LungAgeDev_z", "SystemsAge.MusculoSkeletalAgeDev_z",
"SystemsAgeAgeDev_z", "DunedinPACE_z"),
view_predictors_matrix=FALSE #This is to view the predictors that are used in the imputation
  )

#Impute survey 2 and sensitivity analysis
impute_survey_and_sensitivity_analysis(
  path_to_data="C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
  cols_to_exclude = c("Alcohol.per.week", "Level.of.Education",  #Because these variables have been converted to numbers, harmonized to fewer categories (like diet), or regardet as superfluous (sexual frequency) (see step3)
  "Tobacco.Use", "Hours.Sedentary.Remaining.Awake", "Feel.Well.Rested.days.per.week"), 
  surv_number = 2,
  max_NA_percent_to_remove_cols_main_models = 30,
  max_NA_percent_to_remove_cols_NON_main_models = 50,
  number_of_mice_datasets_to_impute = 5,
  maximum_iterations_per_dataset = 5,
  exclude_diabetes_subgroups=TRUE, #We cant do this imputation for this survey as we have dont have these subgroups there
    cols_to_exclude_from_predictors= c("Patient.ID", "PID", "Collection.Date", "Array", "survey_version", "OMICmAgeAgeDev", "GrimAge.PCAgeDev", "Hannum.PCAgeDev", "Horvath.PCAgeDev",
                                                        "PhenoAge.PCAgeDev", "SystemsAge.BloodAgeDev",
                                                        "SystemsAge.BrainAgeDev", "SystemsAge.InflammationAgeDev",
                                                        "SystemsAge.HeartAgeDev", "SystemsAge.HormoneAgeDev",
                                                        "SystemsAge.ImmuneAgeDev", "SystemsAge.KidneyAgeDev",
                                                        "SystemsAge.LiverAgeDev", "SystemsAge.MetabolicAgeDev",
                                                        "SystemsAge.LungAgeDev", "SystemsAge.MusculoSkeletalAgeDev",
                                                        "SystemsAgeAgeDev", "OMICmAge", "GrimAge.PC","Hannum.PC", "Horvath.PC",
    "Telomere.Values.PC", "PhenoAge.PC", "SystemsAge.Blood",
    "SystemsAge.Brain", "SystemsAge.Inflammation", "SystemsAge.Heart",
    "SystemsAge.Hormone", "SystemsAge.Immune", "SystemsAge.Kidney",
    "SystemsAge.Liver", "SystemsAge.Metabolic", "SystemsAge.Lung",
    "SystemsAge.MusculoSkeletal", "SystemsAge", "DunedinPACE", "OMICmAgeAgeDev_z", "GrimAge.PCAgeDev_z", "Hannum.PCAgeDev_z", "Horvath.PCAgeDev_z",
"PhenoAge.PCAgeDev_z", "SystemsAge.BloodAgeDev_z",
"SystemsAge.BrainAgeDev_z", "SystemsAge.InflammationAgeDev_z",
"SystemsAge.HeartAgeDev_z", "SystemsAge.HormoneAgeDev_z",
"SystemsAge.ImmuneAgeDev_z", "SystemsAge.KidneyAgeDev_z",
"SystemsAge.LiverAgeDev_z", "SystemsAge.MetabolicAgeDev_z",
"SystemsAge.LungAgeDev_z", "SystemsAge.MusculoSkeletalAgeDev_z",
"SystemsAgeAgeDev_z", "DunedinPACE_z"),
view_predictors_matrix=FALSE #This is to view the predictors that are used in the imputation
  )

#Impute survey 3 and sensitivity analysis
impute_survey_and_sensitivity_analysis(
  path_to_data="C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
  cols_to_exclude = c("Alcohol.per.week", "Level.of.Education", "Hours.of.sleep.per.night", #Because these variables have been converted to numbers, harmonized to fewer categories (like diet), or regardet as superfluous (sexual frequency) (see step3)
  "Tobacco.Use", "Hours.Sedentary.Remaining.Awake", "Feel.Well.Rested.days.per.week"), 
  surv_number = 3,
  max_NA_percent_to_remove_cols_main_models = 30,
  max_NA_percent_to_remove_cols_NON_main_models = 50,
  number_of_mice_datasets_to_impute = 5,
  maximum_iterations_per_dataset = 5,
  exclude_diabetes_subgroups=TRUE, #We cant do this imputation for this survey as we have dont have these subgroups there
  cols_to_exclude_from_predictors= c("Patient.ID", "PID", "Collection.Date", "Array", "survey_version", "OMICmAgeAgeDev", "GrimAge.PCAgeDev", "Hannum.PCAgeDev", "Horvath.PCAgeDev",
                                                        "PhenoAge.PCAgeDev", "SystemsAge.BloodAgeDev",
                                                        "SystemsAge.BrainAgeDev", "SystemsAge.InflammationAgeDev",
                                                        "SystemsAge.HeartAgeDev", "SystemsAge.HormoneAgeDev",
                                                        "SystemsAge.ImmuneAgeDev", "SystemsAge.KidneyAgeDev",
                                                        "SystemsAge.LiverAgeDev", "SystemsAge.MetabolicAgeDev",
                                                        "SystemsAge.LungAgeDev", "SystemsAge.MusculoSkeletalAgeDev",
                                                        "SystemsAgeAgeDev", "OMICmAge", "GrimAge.PC","Hannum.PC", "Horvath.PC",
    "Telomere.Values.PC", "PhenoAge.PC", "SystemsAge.Blood",
    "SystemsAge.Brain", "SystemsAge.Inflammation", "SystemsAge.Heart",
    "SystemsAge.Hormone", "SystemsAge.Immune", "SystemsAge.Kidney",
    "SystemsAge.Liver", "SystemsAge.Metabolic", "SystemsAge.Lung",
    "SystemsAge.MusculoSkeletal", "SystemsAge", "DunedinPACE", "OMICmAgeAgeDev_z", "GrimAge.PCAgeDev_z", "Hannum.PCAgeDev_z", "Horvath.PCAgeDev_z",
"PhenoAge.PCAgeDev_z", "SystemsAge.BloodAgeDev_z",
"SystemsAge.BrainAgeDev_z", "SystemsAge.InflammationAgeDev_z",
"SystemsAge.HeartAgeDev_z", "SystemsAge.HormoneAgeDev_z",
"SystemsAge.ImmuneAgeDev_z", "SystemsAge.KidneyAgeDev_z",
"SystemsAge.LiverAgeDev_z", "SystemsAge.MetabolicAgeDev_z",
"SystemsAge.LungAgeDev_z", "SystemsAge.MusculoSkeletalAgeDev_z",
"SystemsAgeAgeDev_z", "DunedinPACE_z"),
view_predictors_matrix=FALSE #This is to view the predictors that are used in the imputation

  )