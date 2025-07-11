library(pacman)

p_load(ggplot2, mice)
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion_metformin().R")
# source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")

metformin_model <- function(interventions_surv1, lifestyle_covariates_surv_1, base_path){


#All groups
#surv 1
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_all_participants"))

results_surv1_all_groups<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_all_groups.xlsx",
save_z_excel = TRUE
)

#only_all_groups_results
GrimAge_model3_all_groups_z<-results_surv1_all_groups$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_all_groups_z<-results_surv1_all_groups$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_all_groups_z<-results_surv1_all_groups$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_all_groups_z$group <- "all_groups"
OMICmAge_model3_all_groups_z$group <- "all_groups"
DunedinPACE_model3_all_groups_z$group <- "all_groups"

#Only prediabetic
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_prediabetics"))

results_surv1_only_prediabetes<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_prediabetics_survey1.xlsx",
save_z_excel = TRUE
)

#only_prediabetes_results
GrimAge_model3_prediabetes_z<-results_surv1_only_prediabetes$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_prediabetes_z<-results_surv1_only_prediabetes$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_prediabetes_z<-results_surv1_only_prediabetes$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_prediabetes_z$group <- "only_prediabetes"
OMICmAge_model3_prediabetes_z$group <- "only_prediabetes"
DunedinPACE_model3_prediabetes_z$group <- "only_prediabetes"




#Only diabetes 2
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_diabetes2"))

results_surv1_only_diabetes2<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_diabetes2_survey1.xlsx",
save_z_excel = TRUE
)

#only_diabetes2_results
GrimAge_model3_only_diabetes2_z<-results_surv1_only_diabetes2$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_diabetes2_z<-results_surv1_only_diabetes2$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_diabetes2_z<-results_surv1_only_diabetes2$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_diabetes2_z$group <- "only_diabetes2"
OMICmAge_model3_only_diabetes2_z$group <- "only_diabetes2"
DunedinPACE_model3_only_diabetes2_z$group <- "only_diabetes2"



#Only Gestational diabetes
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_gestational_diabetes"))

results_surv1_only_gestational_diabetes<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_gestational_diabetes_survey1.xlsx",
save_z_excel = TRUE
)

#only_gestational_diabetes_results
GrimAge_model3_only_gestational_diabetes_z<-results_surv1_only_gestational_diabetes$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_gestational_diabetes_z<-results_surv1_only_gestational_diabetes$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_gestational_diabetes_z<-results_surv1_only_gestational_diabetes$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_gestational_diabetes_z$group <- "only_gestational_diabetes"
OMICmAge_model3_only_gestational_diabetes_z$group <- "only_gestational_diabetes"
DunedinPACE_model3_only_gestational_diabetes_z$group <- "only_gestational_diabetes"



#Only healthy
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_healthy(diabeteswise)"))

results_surv1_only_healthy<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_healthy_survey1.xlsx",
save_z_excel = TRUE
)
# only_healthy_results
GrimAge_model3_only_healthy_z<-results_surv1_only_healthy$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_healthy_z<-results_surv1_only_healthy$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_healthy_z<-results_surv1_only_healthy$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_healthy_z$group <- "only_healthy"
OMICmAge_model3_only_healthy_z$group <- "only_healthy"
DunedinPACE_model3_only_healthy_z$group <- "only_healthy"




#Only diabetes 1
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_diabetes1"))

results_surv1_only_diabetes1<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_diabetes1_survey1.xlsx",
save_z_excel = TRUE
)

#only_diabetes1_results
GrimAge_model3_only_diabetes1_z<-results_surv1_only_diabetes1$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_diabetes1_z<-results_surv1_only_diabetes1$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_diabetes1_z<-results_surv1_only_diabetes1$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_diabetes1_z$group <- "only_diabetes1"
OMICmAge_model3_only_diabetes1_z$group <- "only_diabetes1"
DunedinPACE_model3_only_diabetes1_z$group <- "only_diabetes1"

#__________________________________New groups


#Only insulin_resistant_groups
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_insulin_resistant_groups"))

results_surv1_only_insulin_resistant_groups<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_insulin_resistant_groups_survey1.xlsx",
save_z_excel = TRUE
)

#only_insulin_resistant_groups_results
GrimAge_model3_only_insulin_resistant_groups_z<-results_surv1_only_insulin_resistant_groups$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_insulin_resistant_groups_z<-results_surv1_only_insulin_resistant_groups$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_insulin_resistant_groups_z<-results_surv1_only_insulin_resistant_groups$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_insulin_resistant_groups_z$group <- "only_insulin_resistant_groups"
OMICmAge_model3_only_insulin_resistant_groups_z$group <- "only_insulin_resistant_groups"
DunedinPACE_model3_only_insulin_resistant_groups_z$group <- "only_insulin_resistant_groups"



#Only non_insulin_resistant_groups
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_non_insulin_resistant_groups"))

results_surv1_only_non_insulin_resistant_groups<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_non_insulin_resistant_groups_survey1.xlsx",
save_z_excel = TRUE
)

#only_non_insulin_resistant_groups_results
GrimAge_model3_only_non_insulin_resistant_groups_z<-results_surv1_only_non_insulin_resistant_groups$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_non_insulin_resistant_groups_z<-results_surv1_only_non_insulin_resistant_groups$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_non_insulin_resistant_groups_z<-results_surv1_only_non_insulin_resistant_groups$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_non_insulin_resistant_groups_z$group <- "only_non_insulin_resistant_groups"
OMICmAge_model3_only_non_insulin_resistant_groups_z$group <- "only_non_insulin_resistant_groups"
DunedinPACE_model3_only_non_insulin_resistant_groups_z$group <- "only_non_insulin_resistant_groups"



#Only BMI_over_30
#surv 1 
# Load required data and set objects
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_BMI_over_30"))

results_surv1_only_BMI_over_30<-run_models(
imp_data = imputed_data,
# Define parameters 
interventions = interventions_surv1,
lifestyle_covariates = lifestyle_covariates_surv_1,
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = paste0(base_path, "Output/metformin_analysis_results/"),
suffix = "_only_BMI_over_30_survey1.xlsx",
save_z_excel = TRUE
)

#only_BMI_over_30_results
GrimAge_model3_only_BMI_over_30_z<-results_surv1_only_BMI_over_30$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z
OMICmAge_model3_only_BMI_over_30_z<-results_surv1_only_BMI_over_30$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z
DunedinPACE_model3_only_BMI_over_30_z<-results_surv1_only_BMI_over_30$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z
GrimAge_model3_only_BMI_over_30_z$group <- "only_BMI_over_30"
OMICmAge_model3_only_BMI_over_30_z$group <- "only_BMI_over_30"
DunedinPACE_model3_only_BMI_over_30_z$group <- "only_BMI_over_30"



#______________________________________


# Combine results into a single data frame for each model
GrimAge_model3<-rbind(GrimAge_model3_all_groups_z, GrimAge_model3_only_diabetes1_z, GrimAge_model3_only_diabetes2_z, GrimAge_model3_only_gestational_diabetes_z, GrimAge_model3_only_healthy_z, GrimAge_model3_prediabetes_z, 
                      GrimAge_model3_only_insulin_resistant_groups_z, GrimAge_model3_only_non_insulin_resistant_groups_z, GrimAge_model3_only_BMI_over_30_z)
DunedinPACE_model3<-rbind(DunedinPACE_model3_all_groups_z, DunedinPACE_model3_only_diabetes1_z, DunedinPACE_model3_only_diabetes2_z, DunedinPACE_model3_only_gestational_diabetes_z, DunedinPACE_model3_only_healthy_z, DunedinPACE_model3_prediabetes_z, 
                          DunedinPACE_model3_only_insulin_resistant_groups_z, DunedinPACE_model3_only_non_insulin_resistant_groups_z, DunedinPACE_model3_only_BMI_over_30_z)
OMICmAge_model3<-rbind(OMICmAge_model3_all_groups_z, OMICmAge_model3_only_diabetes1_z, OMICmAge_model3_only_diabetes2_z, OMICmAge_model3_only_gestational_diabetes_z, OMICmAge_model3_only_healthy_z, OMICmAge_model3_prediabetes_z, 
                        OMICmAge_model3_only_insulin_resistant_groups_z, OMICmAge_model3_only_non_insulin_resistant_groups_z, OMICmAge_model3_only_BMI_over_30_z)



# Create forrest plots for Metformin analysis
# Function to filter dataframes by term
filter_by_term <- function(df, term_to_keep) {
  return(df[grepl(term_to_keep, df$term), ])
}



# Filter dataframes to keep only Metformin_new rows
GrimAge_model3 <- filter_by_term(GrimAge_model3, "Metformin_new")
DunedinPACE_model3 <- filter_by_term(DunedinPACE_model3, "Metformin_new")
OMICmAge_model3 <- filter_by_term(OMICmAge_model3, "Metformin_new")

#Temporary line
View(DunedinPACE_model3)

p <- forest_plot_fusion_metformin(GrimAge_model3, DunedinPACE_model3, OMICmAge_model3,
                                source_names = c("GrimAge_model3", "DunedinPACE_model3", "OMICmAge_model3"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p)

ggsave(filename = paste0(base_path, "Output/metformin_analysis_results/forest_plot_fusion_model3_z.png"), plot = p)

}

# lifestyle_covariates_surv_1 <- c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
#   "Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric")

# lifestyle_covariates_surv_2 <- c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
#   "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Feel.Well.Rested.days.per.week_numeric")

# lifestyle_covariates_surv_3 <- c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
#   "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Hours.of.sleep.per.night_numeric")

# interventions_metformin_analysis <- c("Metformin_new", "NAD", "TA65", 
#   "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new")


# # Run the models
# metformin_model(interventions_surv1 = interventions_metformin_analysis, 
#   lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
#   base_path = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/")
