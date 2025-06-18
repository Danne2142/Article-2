source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/main_models")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/sex_sensitivity_analysis")




lifestyle_covariates_surv_1 <- c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric")

lifestyle_covariates_surv_2 <- c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Feel.Well.Rested.days.per.week_numeric")

lifestyle_covariates_surv_3 <- c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
  "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Hours.of.sleep.per.night_numeric")

interventions <- c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine")

path<- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/"

# Run the main models
main_models(interventions_to_use = interventions, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
  base_path = path)

# Run the sex sensitivity analysis
sex_sensitivity_analysis(
  interventions_surv1 = interventions_surv1,
  interventions_surv2_3 = interventions_surv2_3,
  lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1,
  lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2,
  lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
  base_path = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/"
)

# Run the age sensitivity analysis
age_sensitivity_analysis(
  interventions_surv1 = interventions_surv1,
  interventions_surv2_3 = interventions_surv2_3,
  lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
  base_path = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/")



# Run the sensitivity analysis
sensitivity_analysis_ethnicity(interventions_to_use = interventions, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
  base_path = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/")


#Metformin