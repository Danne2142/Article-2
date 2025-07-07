source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/main_models().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/sex_sensitivity_analysis().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/sensitivity_analysis_ethnicity().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/age_sensitivity_analysis().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/metformin_model().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion_metformin().R")




lifestyle_covariates_surv_1 <- c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric")

lifestyle_covariates_surv_2 <- c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Feel.Well.Rested.days.per.week_numeric")

lifestyle_covariates_surv_3 <- c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
  "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Hours.of.sleep.per.night_numeric")

interventions <- c("NAD", "TA65", "sulforaphane", "DHEA_new", "Metformin_new", "Resveratrol_new", "vitaminD")

path<- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/"

# Run the main models first time to select significant interventions in at least one survey
main_models_p_filter_results <- main_models(
  interventions_surv1 = interventions,
  interventions_surv2 = interventions,
  interventions_surv3 = interventions, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
  base_path = path,
  p_filter_subjects = "all" # Options: deafult is none
  )

#Update the interventions and lifestyle covariates for the sensitivity analyses according to p-filters in the main models
interventions_small_p_surv1<-main_models_p_filter_results$surv1$interventions_small_p
interventions_small_p_surv2<-main_models_p_filter_results$surv2$interventions_small_p
interventions_small_p_surv3<-main_models_p_filter_results$surv3$interventions_small_p

print("Interventions with small p-value:")
print("Survey 1:")
print(interventions_small_p_surv1)
print("Survey 2:")
print(interventions_small_p_surv2)
print("Survey 3:")
print(interventions_small_p_surv3)

lifestyle_covariates_small_p_surv_1 <-main_models_p_filter_results$surv1$lifestyle_covariates_updated
lifestyle_covariates_small_p_surv_2 <-main_models_p_filter_results$surv2$lifestyle_covariates_updated
lifestyle_covariates_small_p_surv_3 <-main_models_p_filter_results$surv3$lifestyle_covariates_updated 

print("Lifestyle with small p-value:")
print("Survey 1:")
print(lifestyle_covariates_small_p_surv_1)
print("Survey 2:")
print(lifestyle_covariates_small_p_surv_2)
print("Survey 3:")
print(lifestyle_covariates_small_p_surv_3)

#Merge interventions_small_p_surv1, interventions_small_p_surv2, and interventions_small_p_surv3 into a single list with no duplicates
interventions_small_p_for_all_outcomes_in_at_least_one_survey <- unique(c(interventions_small_p_surv1, interventions_small_p_surv2, interventions_small_p_surv3))
print("Interventions with small p for all 3 biomarkers in at least one survey:")
print(interventions_small_p_for_all_outcomes_in_at_least_one_survey)

# Run the main models a second time with significant interventions in at least one survey
main_models_p_filter_results <- main_models(
  interventions_surv1 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv2 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv3 = interventions_small_p_for_all_outcomes_in_at_least_one_survey, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
  base_path = path,
  p_filter_subjects = "only_lifestyle_covariates" # Options: deafult is none
  )



# Run the sex sensitivity analysis
sex_sensitivity_analysis(
  interventions_surv1 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv2 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv3 = interventions_small_p_for_all_outcomes_in_at_least_one_survey, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_small_p_surv_1,
  lifestyle_covariates_surv_2 = lifestyle_covariates_small_p_surv_2,
  lifestyle_covariates_surv_3 = lifestyle_covariates_small_p_surv_3,
  base_path = path)

# Run the age sensitivity analysis
age_sensitivity_analysis(
  interventions_surv1 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv2 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv3 = interventions_small_p_for_all_outcomes_in_at_least_one_survey, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_small_p_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_small_p_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_small_p_surv_3,
  base_path = path)

# Run the ethnicity sensitivity analysis
sensitivity_analysis_ethnicity(
  interventions_surv1 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv2 = interventions_small_p_for_all_outcomes_in_at_least_one_survey,
  interventions_surv3 = interventions_small_p_for_all_outcomes_in_at_least_one_survey, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_small_p_surv_1, 
  lifestyle_covariates_surv_2 = lifestyle_covariates_small_p_surv_2, 
  lifestyle_covariates_surv_3 = lifestyle_covariates_small_p_surv_3,
  base_path = path)



# Run the metformin diabetes subgroup models
#remove vitaminD from interventions_small_p_for_all_outcomes_in_at_least_one_survey because it is uniform for certain diabetes subgroups
interventions_small_p_for_all_outcomes_in_at_least_one_survey <- interventions_small_p_for_all_outcomes_in_at_least_one_survey[interventions_small_p_for_all_outcomes_in_at_least_one_survey != "vitaminD"] #REMOVE THIS LINE IF NEW DATA COMES

metformin_model(interventions_surv1 = interventions_small_p_for_all_outcomes_in_at_least_one_survey, 
  lifestyle_covariates_surv_1 = lifestyle_covariates_small_p_surv_1, 
  base_path = path)
