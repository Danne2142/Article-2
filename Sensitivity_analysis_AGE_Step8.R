
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")


library(pacman)
p_load(mice)


# Generate sensitivity analysis for young
print("Generate sensitivity analysis for young")
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_younger")   
#rename object
imputed_survey1_younger <- imputed_data
df1_imputed_survey1_younger<-complete(imputed_data, 1)

results_younger_survey1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey1_younger,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_younger_survey1")

  #Generate sensitivity analysis for old
print("Generate sensitivity analysis for old")
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_older")
#rename object
imputed_survey1_older <- imputed_data
df1_imputed_survey1_older<-complete(imputed_data, 1)

results_older_survey1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey1_older,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_older_survey1")

