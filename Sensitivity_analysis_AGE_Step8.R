
library(pacman)
p_load(mice)

source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")

# SURVEY 1
print("Generate sensitivity analysis for survey 1")

# Generate sensitivity analysis for younger
print("Generate sensitivity analysis for younger")

# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_younger")
#rename object
imputed_survey1_only_younger <- imputed_data
df1_imputed_survey1_only_younger<-complete(imputed_data, 1)

results_only_younger_survey1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey1_only_younger,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/",
  suffix = "_only_younger_survey1.xlsx")


# Generate sensitivity analysis for older
print("Generate sensitivity analysis for older")
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_only_older")
#rename object
imputed_survey1_only_older <- imputed_data
df1_imputed_survey1_only_older<-complete(imputed_data, 1)

results_only_older_survey1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey1_only_older,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/",
  suffix = "_only_older_survey1.xlsx")


#SURVEY 2
print("Generate sensitivity analysis for survey 2")

# Generate sensitivity analysis for younger
print("Generate sensitivity analysis for younger")

# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey2_only_younger")
#rename object
imputed_survey2_only_younger <- imputed_data
df2_imputed_survey2_only_younger<-complete(imputed_data, 2)

results_only_younger_survey2<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level", "harmonized_diet", "organ_systems_afflicted_by_disease", "Feel.Well.Rested.days.per.week_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey2_only_younger,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/",
  suffix = "_only_younger_survey2.xlsx")


# Generate sensitivity analysis for older
print("Generate sensitivity analysis for older")
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey2_only_older")
#rename object
imputed_survey2_only_older <- imputed_data
df2_imputed_survey2_only_older<-complete(imputed_data, 2)

results_only_older_survey2<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level", "harmonized_diet", "organ_systems_afflicted_by_disease", "Feel.Well.Rested.days.per.week_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey2_only_older,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/",
  suffix = "_only_older_survey2.xlsx")


#SURVEY 3
print("Generate sensitivity analysis for survey 3")

# Generate sensitivity analysis for younger
print("Generate sensitivity analysis for younger")

# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey3_only_younger")
#rename object
imputed_survey3_only_younger <- imputed_data
df3_imputed_survey3_only_younger<-complete(imputed_data, 3)

results_only_younger_survey3<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
  "sedentary_level","Red.Meat.times.per.week", "harmonized_diet", "organ_systems_afflicted_by_disease", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey3_only_younger,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/",
  suffix = "_only_younger_survey3.xlsx")


# Generate sensitivity analysis for older
print("Generate sensitivity analysis for older")
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey3_only_older")
#rename object
imputed_survey3_only_older <- imputed_data
df3_imputed_survey3_only_older<-complete(imputed_data, 3)

results_only_older_survey3<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
  "sedentary_level","Red.Meat.times.per.week", "harmonized_diet", "organ_systems_afflicted_by_disease", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imputed_survey3_only_older,
  savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/",
  suffix = "_only_older_survey1.xlsx")




#GENERATE METAANALYSIS younger
#Create meta analysis for SD versions of biomarkers

print("Generating meta analysis for SD models")

#Run meta models for Model 3 younger
meta_DunedinPACE_Model3_z<-MetaAnalyse(
    survey1 = results_only_younger_survey1$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z, 
    survey2 = results_only_younger_survey2$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z,
    survey3 = results_only_younger_survey3$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z, 
    savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/", 
    model_name = "DunedinPACE_Model3_only_younger_z")

meta_OMICmAge_Model3_z<-MetaAnalyse(
    survey1 = results_only_younger_survey1$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z,
    survey2 = results_only_younger_survey2$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z,
    survey3 = results_only_younger_survey3$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z, 
    savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/", 
    model_name = "OMICmAge_Model3_only_younger_z")

meta_GrimAge_Model3_z<-MetaAnalyse(  
    survey1 = results_only_younger_survey1$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z, 
    survey2 = results_only_younger_survey2$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z,
    survey3 = results_only_younger_survey3$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z,
    savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/", 
    model_name = "GrimAge_PC_Model3_only_younger_z")

#Plot younger
p1 <- forestplot_fusion(meta_DunedinPACE_Model3_z, meta_OMICmAge_Model3_z, meta_GrimAge_Model3_z,
                                source_names = c("meta_DunedinPACE_Model3_z", "meta_OMICmAge_Model3_z", "meta_GrimAge_Model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p1)
ggsave(filename = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/forest_plot_fusion_model3_only_younger_z.png", plot = p1)



#Run meta models for Model 3 older
meta_DunedinPACE_Model3_z<-MetaAnalyse(
    survey1 = results_only_older_survey1$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z, 
    survey2 = results_only_older_survey2$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z,
    survey3 = results_only_older_survey3$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z, 
    savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/", 
    model_name = "DunedinPACE_Model3_only_older_z")

meta_OMICmAge_Model3_z<-MetaAnalyse(
    survey1 = results_only_older_survey1$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z,
    survey2 = results_only_older_survey2$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z,
    survey3 = results_only_older_survey3$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z, 
    savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/", 
    model_name = "OMICmAge_Model3_only_older_z")

meta_GrimAge_Model3_z<-MetaAnalyse(
    survey1 = results_only_older_survey1$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z, 
    survey2 = results_only_older_survey2$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z,
    survey3 = results_only_older_survey3$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z,
    savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/", 
    model_name = "GrimAge_Model3_only_older_z")




#Plot older
p2 <- forestplot_fusion(meta_DunedinPACE_Model3_z, meta_OMICmAge_Model3_z, meta_GrimAge_Model3_z,
                                source_names = c("meta_DunedinPACE_Model3_z", "meta_OMICmAge_Model3_z", "meta_GrimAge_Model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p2)
ggsave(filename = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/forest_plot_fusion_model3_only_older_z.png", plot = p2)


