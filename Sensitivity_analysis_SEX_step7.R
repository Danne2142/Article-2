
library(pacman)
p_load(mice)

source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")

# SURVEY 1
print("Generate sensitivity analysis for survey 1")

# Generate sensitivity analysis for males
print("Generate sensitivity analysis for males")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_males")
#rename object
imputed_survey1_only_males <- imputed_data
df1_imputed_survey1_only_males<-complete(imputed_data, 1)

results_only_males_survey1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey1_only_males,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_males_survey1")


# Generate sensitivity analysis for females
print("Generate sensitivity analysis for females")
# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_females")
#rename object
imputed_survey1_only_females <- imputed_data
df1_imputed_survey1_only_females<-complete(imputed_data, 1)

results_only_females_survey1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey1_only_females,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_females_survey1")


#SURVEY 2
print("Generate sensitivity analysis for survey 2")

# Generate sensitivity analysis for males
print("Generate sensitivity analysis for males")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey2_only_males")
#rename object
imputed_survey2_only_males <- imputed_data
df2_imputed_survey2_only_males<-complete(imputed_data, 2)

results_only_males_survey2<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey2_only_males,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_males_survey2")


# Generate sensitivity analysis for females
print("Generate sensitivity analysis for females")
# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey2_only_females")
#rename object
imputed_survey2_only_females <- imputed_data
df2_imputed_survey2_only_females<-complete(imputed_data, 2)

results_only_females_survey2<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey2_only_females,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_only_females_survey2")


#SURVEY 3
print("Generate sensitivity analysis for survey 3")

# Generate sensitivity analysis for males
print("Generate sensitivity analysis for males")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 3 - Vscode/Output/imputed_survey3_only_males")
#rename object
imputed_survey3_only_males <- imputed_data
df3_imputed_survey3_only_males<-complete(imputed_data, 3)

results_only_males_survey3<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey3_only_males,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 3 - Vscode/Output/",
  suffix = "_only_males_survey3")


# Generate sensitivity analysis for females
print("Generate sensitivity analysis for females")
# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 3 - Vscode/Output/imputed_survey3_only_females")
#rename object
imputed_survey3_only_females <- imputed_data
df3_imputed_survey3_only_females<-complete(imputed_data, 3)

results_only_females_survey3<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age"),
  imp_data = imputed_survey3_only_females,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 3 - Vscode/Output/",
  suffix = "_only_females_survey3")




#GENERATE METAANALYSIS MALES
#Create meta analysis for SD versions of biomarkers

print("Generating meta analysis for SD models")

#Run meta models for Model 3 males
meta_DunedinPACE_Model3_z<-MetaAnalyse(
    survey1 = results_only_males_survey1$surv_results_sd$surv_results_model1_sd$DunedinPACE_Model3_z, 
    survey2 = results_only_males_survey2$surv_results_sd$surv_results_model1_sd$DunedinPACE_Model3_z,
    survey3 = results_only_males_survey3$surv_results_sd$surv_results_model1_sd$DunedinPACE_Model3_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "DunedinPACE_Model1_z")

meta_OMICmAge_Model3_z<-MetaAnalyse(
    survey1 = results_only_males_survey1$surv_results_sd$surv_results_model1_sd$OMICmAge_Model3_z,
    survey2 = results_only_males_survey2$surv_results_sd$surv_results_model1_sd$OMICmAge_Model3_z,
    survey3 = results_only_males_survey3$surv_results_sd$surv_results_model1_sd$OMICmAge_Model3_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "OMICmAge_Model1_z")

meta_GrimAge_Model3_z<-MetaAnalyse(  
    survey1 = results_only_males_survey1$surv_results_sd$surv_results_model1_sd$GrimAge_Model3_z, 
    survey2 = results_only_males_survey2$surv_results_sd$surv_results_model1_sd$GrimAge_Model3_z,
    survey3 = results_only_males_survey3$surv_results_sd$surv_results_model1_sd$GrimAge_Model3_z,
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "GrimAge_PCAgeDev_Model1")

#Run meta models for Model 3 females
meta_DunedinPACE_Model3_z<-MetaAnalyse(
    survey1 = results_only_males_survey1$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model3_z, 
    survey2 = results_only_males_survey2$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model3_z,
    survey3 = results_only_males_survey3$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model3_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "DunedinPACE_Model2_z")

meta_OMICmAge_Model3_z<-MetaAnalyse(
    survey1 = results_only_males_survey1$surv_results_sd$surv_results_model2_sd$OMICmAge_Model3_z,
    survey2 = results_only_males_survey2$surv_results_sd$surv_results_model2_sd$OMICmAge_Model3_z,
    survey3 = results_only_males_survey3$surv_results_sd$surv_results_model2_sd$OMICmAge_Model3_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "OMICmAge_Model2_z")

meta_GrimAge_Model3_z<-MetaAnalyse(
    survey1 = results_only_males_survey1$surv_results_sd$surv_results_model2_sd$GrimAge_Model3_z, 
    survey2 = results_only_males_survey2$surv_results_sd$surv_results_model2_sd$GrimAge_Model3_z,
    survey3 = results_only_males_survey3$surv_results_sd$surv_results_model2_sd$GrimAge_Model3_z,
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", 
    model_name = "GrimAge_Model2_z")


#Creat fused forest plot for SD meta models
# Model1
p1 <- forestplot_fusion(meta_DunedinPACE_Model1_z, meta_OMICmAge_Model1_z, meta_GrimAge_Model1_z,
                                source_names = c("meta_DunedinPACE_Model1_z", "meta_OMICmAge_Model1_z", "meta_GrimAge_Model1_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p1)
ggsave(filename = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/forest_plot_fusion_model1_z.png", plot = p1)


#Model2
p2 <- forestplot_fusion(meta_DunedinPACE_Model2_z, meta_OMICmAge_Model2_z, meta_GrimAge_Model2_z,
                                source_names = c("meta_DunedinPACE_Model2_z", "meta_OMICmAge_Model2_z", "meta_GrimAge_Model2_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p2)
ggsave(filename = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/forest_plot_fusion_model2_z.png", plot = p2)



#Model3
p3 <- forestplot_fusion(meta_DunedinPACE_Model3_z, meta_OMICmAge_Model3_z, meta_GrimAge_Model3_z,
                                source_names = c("meta_DunedinPACE_Model3_z", "meta_OMICmAge_Model3_z", "meta_GrimAge_Model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p3)
ggsave(filename = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/forest_plot_fusion_model3_z.png", plot = p3)



