


source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")


library(pacman)
p_load(mice)


# Generate main models
print("Generate main models")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1")
#rename object
imp_data_surv1 <- imputed_data
df1_imp_data_surv1<-complete(imputed_data, 1)


# # For all columns in your dataset, calculate missing percentage
# missing_summary <- sapply(df1_imp_data_surv1, function(x) mean(is.na(x)) * 100)
# missing_df <- data.frame(
#   Column = names(missing_summary),
#   Missing_Percentage = missing_summary
# )

# # Check if not all values in each column are identical (i.e., at least 2 distinct values)
# Identical_summary <- sapply(df1_imp_data_surv1, function(x) length(unique(x)) == 1)
# Identical_df <- data.frame(
#   Column = names(Identical_summary),
#   All_Identical = Identical_summary
# )


results_surv1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv1,
  saveModel1=TRUE,
  saveModel1SD=TRUE,
  saveModel2=TRUE,
  saveModel2SD=TRUE,
  saveModel3=TRUE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_main_survey1") 

print("Generate main models for surv 2")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey2")
#rename object
imp_data_surv2 <- imputed_data
df1_imp_data_surv2<-complete(imputed_data, 1)


results_surv2<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level","Red.Meat.times.per.week", "Processed.Food.times.per.week", "Feel.Well.Rested.days.per.week"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv2,
  saveModel1=TRUE,
  saveModel1SD=TRUE,
  saveModel2=TRUE,
  saveModel2SD=TRUE,
  saveModel3=TRUE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_main_survey2") 





print("Generate main models for surv 3")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey3")
#rename object
imp_data_surv3 <- imputed_data
df1_imp_data_surv3<-complete(imputed_data, 1)
print(colnames(df1_imp_data_surv3))


results_surv3<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
  "sedentary_level","Red.Meat.times.per.week", "Processed.Food.times.per.week", 
  "Feel.Well.Rested.days.per.week", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv3,
  saveModel1=TRUE,
  saveModel1SD=TRUE,
  saveModel2=TRUE,
  saveModel2SD=TRUE,
  saveModel3=TRUE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_main_survey3") 

test<-results_surv3$surv_results_raw
test2<-test$surv_results_model1_raw
test3<-test2

#Run models for Model 1 raw
meta_model1_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$DunedinPACE_Model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$DunedinPACE_Model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$DunedinPACE_Model1, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "model1_DunedinPACE")

meta_model1_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_Model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_Model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_Model1, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "model1_OMICmAgeAgeDev")

meta_model1_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_Model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_Model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_Model1, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "model1_GrimAge_PCAgeDev")

#Create a uniform df
meta_model1_all_outcomes<-rbind(meta_model1_DunedinPACE, meta_model1_OMICmAgeAgeDev, meta_model1_GrimAge_PCAgeDev)
