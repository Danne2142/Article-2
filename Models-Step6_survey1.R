


source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")


  library(pacman)
  p_load(mice)

  # Test to run functions
  load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1")
  #rename object
  imp_data_surv1 <- imputed_data
  df1_imp_data_surv1<-complete(imputed_data, 1)



# Generate main models



run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
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
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_main") 




# Generate sensitivity analysis for diabetics


run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_diabetics") 



# Generate sensitivity analysis for prediabetics

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
                    "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
                    "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
                                   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
                                   "Exercise.per.week_numeric", "Exercise.Type",
                                   "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                                   "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imp_data_surv1,
  saveModel1 = FALSE,
  saveModel1SD = FALSE,
  saveModel2 = FALSE,
  saveModel2SD = FALSE,
  saveModel3 = FALSE,
  saveModel3SD = TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_prediadetics"
)


# Generate sensitivity analysis for non diabetic type 2 and non prediabetic

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_non_prediabetics_non_diabetics")


# Generate sensitivity analysis for males

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_males")


# Generate sensitivity analysis for females

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_females")


# Generate sensitivity analysis for old

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Biological.Sex"),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_old")


# Generate sensitivity analysis for young

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Biological.Sex"),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_young")



