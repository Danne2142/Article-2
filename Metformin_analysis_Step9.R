
library(pacman)

p_load(ggplot2, mice)
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models_metformin().R")






#Only diabetes 2
#surv 1 
# Load required data and set objects
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_diabetes2")

results_surv1_only_diabetes2<-run_models_metformin(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates = c("Alcohol_per_week_numeric", "Education_levels_numeric", "Stress.Level", 
                          "Tobacco.Use.Numeric", "Exercise.per.week_numeric", "Exercise.Type",
                          "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                          "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/",
suffix = "_only_prediabetics_survey1"
)

#only_diabetes2_results
GrimAge_Model2_z<-results_surv1_only_diabetes2$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z
OMICmAge_model2_z<-results_surv1_only_diabetes2$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z
DunedinPACE_Model2_z<-results_surv1_only_diabetes2$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z
only_diabetes2_results<-rbind(GrimAge_Model2_z, OMICmAge_model2_z, DunedinPACE_Model2_z) 
only_diabetes2_results$group <- "only_diabetes2"


#Only Gestational diabetes
#surv 1 
# Load required data and set objects
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_gestational_diabetes")

results_surv1_only_gestational_diabetes<-run_models_metformin(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates = c("Alcohol_per_week_numeric", "Education_levels_numeric", "Stress.Level", 
                          "Tobacco.Use.Numeric", "Exercise.per.week_numeric", "Exercise.Type",
                          "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                          "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/",
suffix = "_only_prediabetics_survey1"
)

#only_gestational_diabetes_results
GrimAge_Model2_z<-results_surv1_only_gestational_diabetes$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z
OMICmAge_model2_z<-results_surv1_only_gestational_diabetes$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z
DunedinPACE_Model2_z<-results_surv1_only_gestational_diabetes$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z
only_gestational_diabetes_results<-rbind(GrimAge_Model2_z, OMICmAge_model2_z, DunedinPACE_Model2_z)
only_gestational_diabetes_results$group <- "only_gestational_diabetes"


#Only healthy
#surv 1 
# Load required data and set objects
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_healthy(diabeteswise)")

results_surv1_only_healthy<-run_models_metformin(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates = c("Alcohol_per_week_numeric", "Education_levels_numeric", "Stress.Level", 
                          "Tobacco.Use.Numeric", "Exercise.per.week_numeric", "Exercise.Type",
                          "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                          "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/",
suffix = "_only_healthy_survey1"
)
# only_healthy_results
GrimAge_Model2_z<-results_surv1_only_healthy$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z
OMICmAge_model2_z<-results_surv1_only_healthy$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z
DunedinPACE_Model2_z<-results_surv1_only_healthy$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z
only_healthy_results<-rbind(GrimAge_Model2_z, OMICmAge_model2_z, DunedinPACE_Model2_z)
only_healthy_results$group <- "only_healthy"



#Only diebetes 1
#surv 1 
# Load required data and set objects
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_diabetes1")

results_surv1_only_diabetes1<-run_models_metformin(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates = c("Alcohol_per_week_numeric", "Education_levels_numeric", "Stress.Level", 
                          "Tobacco.Use.Numeric", "Exercise.per.week_numeric", "Exercise.Type",
                          "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                          "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/",
suffix = "_only_diabetes_survey1"
)

#only_diabetes1_results
GrimAge_Model2_z<-results_surv1_only_diabetes1$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z
OMICmAge_model2_z<-results_surv1_only_diabetes1$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z
DunedinPACE_Model2_z<-results_surv1_only_diabetes1$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z
only_diabetes1_results<-rbind(GrimAge_Model2_z, OMICmAge_model2_z, DunedinPACE_Model2_z)
only_diabetes1_results$group <- "only_diabetes1"

#Only prediabetic
#surv 1 
# Load required data and set objects
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_prediabetics")

results_surv1_only_prediabetes<-run_models_metformin(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates = c("Alcohol_per_week_numeric", "Education_levels_numeric", "Stress.Level", 
                          "Tobacco.Use.Numeric", "Exercise.per.week_numeric", "Exercise.Type",
                          "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                          "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/",
suffix = "_only_prediabetics_survey1"
)

#only_prediabetes_results
GrimAge_Model2_z<-results_surv1_only_prediabetes$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z
OMICmAge_model2_z<-results_surv1_only_prediabetes$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z
DunedinPACE_Model2_z<-results_surv1_only_prediabetes$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z
only_prediabetes_results<-rbind(GrimAge_Model2_z, OMICmAge_model2_z, DunedinPACE_Model2_z)
only_prediabetes_results$group <- "only_prediabetes"


# Fuse dataframes
# Combine all results into one dataframe
metformin_results<-rbind(only_diabetes2_results, only_gestational_diabetes_results, only_healthy_results, only_diabetes1_results, only_prediabetes_results)