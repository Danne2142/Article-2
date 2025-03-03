


source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")


library(pacman)
p_load(mice)


# Generate main models
print("Generate main models")

# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey2")
#rename object
imp_data_surv1 <- imputed_data
df1_imp_data_surv1<-complete(imputed_data, 1)
print(colnames(df1_imp_data_surv1))


# For all columns in your dataset
missing_summary <- sapply(df1_imp_data_surv1, function(x) mean(is.na(x)) * 100)
missing_df <- data.frame(
  Column = names(missing_summary),
  Missing_Percentage = missing_summary
)

KOLLA UNIQUE VÄRDEN PÅ ALLA KOLLUMNER I DF!!!

run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level","Red.Meat.times.per.week", "Processed.Food.times.per.week", "Feel.Well.Rested.days.per.week"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv1,
  saveModel1=TRUE,
  saveModel1SD=TRUE,
  saveModel2=TRUE,
  saveModel2SD=TRUE,
  saveModel3=TRUE,
  saveModel3SD=TRUE,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_main_survey2") 

