library(pacman)
p_load(mice, writexl)

source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")

age_sensitivity_analysis <- function(interventions_surv1, interventions_surv2_3, lifestyle_covariates_surv_1, lifestyle_covariates_surv_2, lifestyle_covariates_surv_3, base_path){

# SURVEY 1
print("Generate sensitivity analysis for survey 1")

# Generate sensitivity analysis for younger
print("Generate sensitivity analysis for younger")

# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_younger"))
#rename object
imputed_survey1_only_younger <- imputed_data
df1_imputed_survey1_only_younger<-complete(imputed_data, 1)

results_only_younger_survey1<-run_models(
  interventions = interventions_surv1,
  lifestyle_covariates = lifestyle_covariates_surv_1,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey1_only_younger,
  savePath = paste0(base_path, "Output/age_sensitivity_analysis/"),
  suffix = "_only_younger_survey1.xlsx")


# Generate sensitivity analysis for older
print("Generate sensitivity analysis for older")
# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_older"))
#rename object
imputed_survey1_only_older <- imputed_data
df1_imputed_survey1_only_older<-complete(imputed_data, 1)

results_only_older_survey1<-run_models(
  interventions = interventions_surv1,
  lifestyle_covariates = lifestyle_covariates_surv_1,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey1_only_older,
  savePath = paste0(base_path, "Output/age_sensitivity_analysis/"),
  suffix = "_only_older_survey1.xlsx")


#SURVEY 2
print("Generate sensitivity analysis for survey 2")

# Generate sensitivity analysis for younger
print("Generate sensitivity analysis for younger")

# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey2_only_younger"))
#rename object
imputed_survey2_only_younger <- imputed_data
df2_imputed_survey2_only_younger<-complete(imputed_data, 2)

results_only_younger_survey2<-run_models(
  interventions = interventions_surv2_3,
  lifestyle_covariates = lifestyle_covariates_surv_2,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey2_only_younger,
  savePath = paste0(base_path, "Output/age_sensitivity_analysis/"),
  suffix = "_only_younger_survey2.xlsx")


# Generate sensitivity analysis for older
print("Generate sensitivity analysis for older")
# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey2_only_older"))
#rename object
imputed_survey2_only_older <- imputed_data
df2_imputed_survey2_only_older<-complete(imputed_data, 2)

results_only_older_survey2<-run_models(
  interventions = interventions_surv2_3,
  lifestyle_covariates = lifestyle_covariates_surv_2,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey2_only_older,
  savePath = paste0(base_path, "Output/age_sensitivity_analysis/"),
  suffix = "_only_older_survey2.xlsx")


#SURVEY 3
print("Generate sensitivity analysis for survey 3")

# Generate sensitivity analysis for younger
print("Generate sensitivity analysis for younger")

# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey3_only_younger"))
#rename object
imputed_survey3_only_younger <- imputed_data
df3_imputed_survey3_only_younger<-complete(imputed_data, 3)

results_only_younger_survey3<-run_models(
  interventions = interventions_surv2_3,
  lifestyle_covariates = lifestyle_covariates_surv_3,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey3_only_younger,
  savePath = paste0(base_path, "Output/age_sensitivity_analysis/"),
  suffix = "_only_younger_survey3.xlsx")


# Generate sensitivity analysis for older
print("Generate sensitivity analysis for older")
# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey3_only_older"))
#rename object
imputed_survey3_only_older <- imputed_data
df3_imputed_survey3_only_older<-complete(imputed_data, 3)

results_only_older_survey3<-run_models(
  interventions = interventions_surv2_3,
  lifestyle_covariates = lifestyle_covariates_surv_3,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey3_only_older,
  savePath = paste0(base_path, "Output/age_sensitivity_analysis/"),
  suffix = "_only_older_survey3.xlsx")


#GENERATE METAANALYSIS younger
#Create meta analysis for SD versions of biomarkers

print("Generating meta analysis for SD models")

#Run meta models for model 3 
meta_DunedinPACE_model3_z<-MetaAnalyse(
    survey1 = results_only_younger_survey1$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
    survey2 = results_only_younger_survey2$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z,
    survey3 = results_only_younger_survey3$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
    savePath = paste0(base_path, "Output/age_sensitivity_analysis/"), 
    model_name = "DunedinPACE_model3_only_younger_z")

meta_OMICmAge_model3_z<-MetaAnalyse(
    survey1 = results_only_younger_survey1$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
    survey2 = results_only_younger_survey2$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
    survey3 = results_only_younger_survey3$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z, 
    savePath = paste0(base_path, "Output/age_sensitivity_analysis/"), 
    model_name = "OMICmAge_model3_only_younger_z")

meta_GrimAge_model3_z<-MetaAnalyse(  
    survey1 = results_only_younger_survey1$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z, 
    survey2 = results_only_younger_survey2$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
    survey3 = results_only_younger_survey3$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
    savePath = paste0(base_path, "Output/age_sensitivity_analysis/"), 
    model_name = "GrimAge_PC_model3_only_younger_z")

# Save meta-analysis tables younger
write_xlsx(meta_DunedinPACE_model3_z, paste0(base_path, "Output/age_sensitivity_analysis/", "meta_DunedinPACE_model3_only_younger_z_table.xlsx"))
write_xlsx(meta_OMICmAge_model3_z, paste0(base_path, "Output/age_sensitivity_analysis/", "meta_OMICmAge_model3_only_younger_z_table.xlsx"))
write_xlsx(meta_GrimAge_model3_z, paste0(base_path, "Output/age_sensitivity_analysis/", "meta_GrimAge_model3_only_younger_z_table.xlsx"))


#Plot younger
p1 <- forestplot_fusion(meta_DunedinPACE_model3_z, meta_OMICmAge_model3_z, meta_GrimAge_model3_z,
                                source_names = c("meta_DunedinPACE_model3_z", "meta_OMICmAge_model3_z", "meta_GrimAge_model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p1)
ggsave(filename = paste0(base_path, "Output/age_sensitivity_analysis/forest_plot_fusion_model3_only_younger_z.png"), plot = p1)



#Run meta models for model 3 older
meta_DunedinPACE_model3_z<-MetaAnalyse(
    survey1 = results_only_older_survey1$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
    survey2 = results_only_older_survey2$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z,
    survey3 = results_only_older_survey3$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
    savePath = paste0(base_path, "Output/age_sensitivity_analysis/"), 
    model_name = "DunedinPACE_model3_only_older_z")

meta_OMICmAge_model3_z<-MetaAnalyse(
    survey1 = results_only_older_survey1$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
    survey2 = results_only_older_survey2$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
    survey3 = results_only_older_survey3$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z, 
    savePath = paste0(base_path, "Output/age_sensitivity_analysis/"), 
    model_name = "OMICmAge_model3_only_older_z")

meta_GrimAge_model3_z<-MetaAnalyse(
    survey1 = results_only_older_survey1$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z, 
    survey2 = results_only_older_survey2$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
    survey3 = results_only_older_survey3$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
    savePath = paste0(base_path, "Output/age_sensitivity_analysis/"), 
    model_name = "GrimAge_model3_only_older_z")

# Save meta-analysis tables older
write_xlsx(meta_DunedinPACE_model3_z, paste0(base_path, "Output/age_sensitivity_analysis/", "meta_DunedinPACE_model3_only_older_z_table.xlsx"))
write_xlsx(meta_OMICmAge_model3_z, paste0(base_path, "Output/age_sensitivity_analysis/", "meta_OMICmAge_model3_only_older_z_table.xlsx"))
write_xlsx(meta_GrimAge_model3_z, paste0(base_path, "Output/age_sensitivity_analysis/", "meta_GrimAge_model3_only_older_z_table.xlsx"))



#Plot older
p2 <- forestplot_fusion(meta_DunedinPACE_model3_z, meta_OMICmAge_model3_z, meta_GrimAge_model3_z,
                                source_names = c("meta_DunedinPACE_model3_z", "meta_OMICmAge_model3_z", "meta_GrimAge_model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p2)
ggsave(filename = paste0(base_path, "Output/age_sensitivity_analysis/forest_plot_fusion_model3_only_older_z.png"), plot = p2)

}

# # Define lifestyle covariates for each survey
# lifestyle_covariates_surv_1 <- c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
#   "Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric")

# lifestyle_covariates_surv_2 <- c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
#   "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Feel.Well.Rested.days.per.week_numeric")

# lifestyle_covariates_surv_3 <- c("Alcohol_per_week_numeric",  
#   "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
#   "sedentary_level_quartiles_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "Hours.of.sleep.per.night_numeric")

# # Define interventions for survey 1 (has additional interventions)
# interventions_surv1 <- c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
#   "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
#   "HRT", "spermidine")

# # Define interventions for surveys 2 and 3
# interventions_surv2_3 <- c("Metformin_new", "NAD", "TA65", 
#   "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
#   "spermidine")

# # Run the age sensitivity analysis
# age_sensitivity_analysis(
#   interventions_surv1 = interventions_surv1,
#   interventions_surv2_3 = interventions_surv2_3,
#   lifestyle_covariates_surv_1 = lifestyle_covariates_surv_1, 
#   lifestyle_covariates_surv_2 = lifestyle_covariates_surv_2, 
#   lifestyle_covariates_surv_3 = lifestyle_covariates_surv_3,
#   base_path = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/")


