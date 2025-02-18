


source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")


  library(pacman)
  p_load(mice)


# Generate main models

# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1")
#rename object
imp_data_surv1 <- imputed_data
df1_imp_data_surv1<-complete(imputed_data, 1)

# run_models(
#   interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
#   "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
#   "HRT", "spermidine"),
#   lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
#   "Exercise.per.week_numeric", "Exercise.Type",
#   "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
#   covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
#   imp_data = imp_data_surv1,
#   saveModel1=TRUE,
#   saveModel1SD=TRUE,
#   saveModel2=TRUE,
#   saveModel2SD=TRUE,
#   saveModel3=TRUE,
#   saveModel3SD=TRUE,
#   savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
#   suffix = "_main") 


# Generate sensitivity analysis for diabetics
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_diabetes2")
#rename object
imputed_survey1_only_diabetes2 <- imputed_data
df1_imp_data_surv1_only_diabetes2<-complete(imputed_data, 1)

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imputed_survey1_only_diabetes2,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_diabetics") 



# Generate sensitivity analysis for prediabetics
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_prediabetics")
#rename object
imputed_survey1_only_prediabetics <- imputed_data
df1_imputed_survey1_only_prediabetics<-complete(imputed_data, 1)

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
  imp_data = imputed_survey1_only_prediabetics,
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
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_healthy")
#rename object
imputed_survey1_only_healthy <- imputed_data
df1_imputed_survey1_only_healthy<-complete(imputed_data, 1)

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imputed_survey1_only_healthy,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_non_prediabetics_non_diabetics")


# Generate sensitivity analysis for males
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_males")
#rename object
imputed_survey1_only_males <- imputed_data
df1_imputed_survey1_only_males<-complete(imputed_data, 1)

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey1_only_males,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_males")


# Generate sensitivity analysis for females
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_females")
#rename object
imputed_survey1_only_females <- imputed_data
df1_imputed_survey1_only_females<-complete(imputed_data, 1)

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey1_only_females,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_females")


# Generate sensitivity analysis for old
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_older")
#rename object
imputed_survey1_older <- imputed_data
df1_imputed_survey1_older<-complete(imputed_data, 1)

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Biological.Sex"),
  imp_data = imputed_survey1_older,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_old")


# Generate sensitivity analysis for young
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_younger")
#rename object
imputed_survey1_younger <- imputed_data
df1_imputed_survey1_younger<-complete(imputed_data, 1)

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Biological.Sex"),
  imp_data = imputed_survey1_younger,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_young")



