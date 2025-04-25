


library(pacman)
p_load(mice)

source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")



# Generate main models
print("Generate main models")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey1_all_participants")
#rename object
imp_data_surv1 <- imputed_data
df1_imp_data_surv1<-complete(imputed_data, 1)


# # For all columns in your dataset, calculate missing percentage
# missing_summary <- sapply(df1_imp_data_surv1, function(x) mean(is.na(x)) * 100)
# missing_df <- data.frame(
#   Column = names(missing_summary),
#   Missing_Percentage = missing_summary
# )

# # Check if not all values in each column are identical (i.e., at least 2 distinct values)
# Identical_summary <- sapply(df1_imp_data_surv1, function(x) length(unique(x)) == 1)
# Identical_df <- data.frame(
#   Column = names(Identical_summary),
#   All_Identical = Identical_summary
# )


results_surv1<-run_models(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", 
  "Main.Diet.Factor" , "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv1,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/",
  suffix = "_survey1_main.xlsx") 

print("Generate main models for surv 2")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey2_all_participants")
#rename object
imp_data_surv2 <- imputed_data
df1_imp_data_surv2<-complete(imputed_data, 1)


results_surv2<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "sedentary_level","Red.Meat.times.per.week", "Processed.Food.times.per.week", "Feel.Well.Rested.days.per.week"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv2,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/",
  suffix = "_survey2_main.xlsx") 


print("Generate main models for surv 3")

# Load corresponding data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputation_results/imputed_survey3_all_participants")
#rename object
imp_data_surv3 <- imputed_data
df1_imp_data_surv3<-complete(imputed_data, 1)
print(colnames(df1_imp_data_surv3))


results_surv3<-run_models(
  interventions = c("Metformin_new", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", 
  "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", "BMI", 
  "sedentary_level","Red.Meat.times.per.week", "Processed.Food.times.per.week", 
  "Feel.Well.Rested.days.per.week", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv3,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/",
  suffix = "_survey3_main.xlsx") 



print("Generating meta analysis for raw models")

#Run meta models for raw
meta_model1_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$DunedinPACE_Model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$DunedinPACE_Model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$DunedinPACE_Model1, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "DunedinPACE_Model1")

meta_model1_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_Model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_Model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_Model1, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "OMICmAgeAgeDev_Model1")

meta_model1_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_Model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_Model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_Model1, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "GrimAge_PCAgeDev_Model1")

#Run models for Model 2 raw
meta_model2_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model2_raw$DunedinPACE_Model2, 
    survey2 = results_surv2$surv_results_raw$surv_results_model2_raw$DunedinPACE_Model2, 
    survey3 = results_surv3$surv_results_raw$surv_results_model2_raw$DunedinPACE_Model2, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "DunedinPACE_Model2")

meta_model2_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model2_raw$OMICmAgeAgeDev_Model2, 
    survey2 = results_surv2$surv_results_raw$surv_results_model2_raw$OMICmAgeAgeDev_Model2, 
    survey3 = results_surv3$surv_results_raw$surv_results_model2_raw$OMICmAgeAgeDev_Model2, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "OMICmAgeAgeDev_Model2")

meta_model2_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model2_raw$GrimAge_PCAgeDev_Model2, 
    survey2 = results_surv2$surv_results_raw$surv_results_model2_raw$GrimAge_PCAgeDev_Model2, 
    survey3 = results_surv3$surv_results_raw$surv_results_model2_raw$GrimAge_PCAgeDev_Model2, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "GrimAge_PCAgeDev_Model2")

#Run models for Model 3 raw
meta_model3_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model3_raw$DunedinPACE_Model3, 
    survey2 = results_surv2$surv_results_raw$surv_results_model3_raw$DunedinPACE_Model3, 
    survey3 = results_surv3$surv_results_raw$surv_results_model3_raw$DunedinPACE_Model3, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "DunedinPACE_Model3")

meta_model3_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model3_raw$OMICmAgeAgeDev_Model3, 
    survey2 = results_surv2$surv_results_raw$surv_results_model3_raw$OMICmAgeAgeDev_Model3, 
    survey3 = results_surv3$surv_results_raw$surv_results_model3_raw$OMICmAgeAgeDev_Model3, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "OMICmAgeAgeDev_Model3")

meta_model3_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model3_raw$GrimAge_PCAgeDev_Model3, 
    survey2 = results_surv2$surv_results_raw$surv_results_model3_raw$GrimAge_PCAgeDev_Model3, 
    survey3 = results_surv3$surv_results_raw$surv_results_model3_raw$GrimAge_PCAgeDev_Model3, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "GrimAge_PCAgeDev_Model3")



#PLOT 
#MODEL1 RAW 
# Create plot for DunedinPACE raw
plot_forest(meta_model1_DunedinPACE, estimate_col = "Estimate", conf.low_col = "lower_CI", 
conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
xlab = "Biological year per chronological year", ylab = "Term", vertical_line = 0, plot_title = "meta_model1_DunedinPACE", 
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model1_DunedinPACE.png")
# Create plot for OMICmAgeAgeDev raw
plot_forest(meta_model1_OMICmAgeAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI", 
conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model1_OMICmAgeAgeDev",
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model1_OMICmAgeAgeDev.png")
# Create plot for GrimAgeAgeDev raw
plot_forest(meta_model1_GrimAge_PCAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI", 
conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model1_GrimAge_PCAgeDev",
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model1_GrimAge_PCAgeDev.png")


#PLOT MODEL2 RAW
# Create plot for DunedinPACE sd
plot_forest(meta_model2_DunedinPACE, estimate_col = "Estimate", conf.low_col = "lower_CI",
 conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
 xlab = "Biological year per chronological year", ylab = "Term", vertical_line = 0, plot_title = "meta_model2_DunedinPACE",
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model2_DunedinPACE.png")
# Create plot for OMICmAgeAgeDev raw
plot_forest(meta_model2_OMICmAgeAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model2_OMICmAgeAgeDev",
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model2_OMICmAgeAgeDev.png")
# Create plot for GrimAgeAgeDev raw
plot_forest(meta_model2_GrimAge_PCAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model2_GrimAge_PCAgeDev",
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model2_GrimAge_PCAgeDev.png")

#PLOT MODEL3 RAW
# Create plot for DunedinPACE raw
plot_forest(meta_model3_DunedinPACE, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "", ylab = "", vertical_line = 0, plot_title = "meta_model3_DunedinPACE",
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model3_DunedinPACE.png")
# Create plot for OMICmAgeAgeDev raw
plot_forest(meta_model3_OMICmAgeAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model3_OMICmAgeAgeDev",
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model3_OMICmAgeAgeDev.png")
# Create plot for GrimAgeAgeDev raw
plot_forest(meta_model3_GrimAge_PCAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model3_GrimAge_PCAgeDev",
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/meta_model3_GrimAge_PCAgeDev.png")


#Create meta analysis for SD versions of biomarkers

print("Generating meta analysis for SD models")


#Run meta models for Model 1 sd
meta_DunedinPACE_Model1_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model1_sd$DunedinPACE_Model1_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model1_sd$DunedinPACE_Model1_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model1_sd$DunedinPACE_Model1_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "DunedinPACE_Model1_z")

meta_OMICmAge_Model1_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model1_sd$OMICmAge_Model1_z,
    survey2 = results_surv2$surv_results_sd$surv_results_model1_sd$OMICmAge_Model1_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model1_sd$OMICmAge_Model1_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "OMICmAge_Model1_z")

meta_GrimAge_Model1_z<-MetaAnalyse(  
    survey1 = results_surv1$surv_results_sd$surv_results_model1_sd$GrimAge_Model1_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model1_sd$GrimAge_Model1_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model1_sd$GrimAge_Model1_z,
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "GrimAge_PC_Model1_z")

#Run meta models for Model 2 sd
meta_DunedinPACE_Model2_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model2_sd$DunedinPACE_Model2_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "DunedinPACE_Model2_z")

meta_OMICmAge_Model2_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z,
    survey2 = results_surv2$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model2_sd$OMICmAge_Model2_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "OMICmAge_Model2_z")

meta_GrimAge_Model2_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model2_sd$GrimAge_Model2_z,
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "GrimAge_PC_Model2_z")

#Run meta models for Model 3 sd
meta_DunedinPACE_Model3_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model3_sd$DunedinPACE_Model3_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "DunedinPACE_Model3_z")

meta_OMICmAge_Model3_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z,
    survey2 = results_surv2$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model3_sd$OMICmAge_Model3_z, 
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "OMICmAge_Model3_z")

meta_GrimAge_Model3_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model3_sd$GrimAge_Model3_z,
    savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/", 
    model_name = "GrimAge_PC_Model3_z")



#Creat fused forest plot for SD models

# Model1
p1 <- forestplot_fusion(meta_DunedinPACE_Model1_z, meta_OMICmAge_Model1_z, meta_GrimAge_Model1_z,
                                source_names = c("meta_DunedinPACE_Model1_z", "meta_OMICmAge_Model1_z", "meta_GrimAge_Model1_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p1)
ggsave(filename = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/forest_plot_fusion_model1_z.png", plot = p1)


#Model2
p2 <- forestplot_fusion(meta_DunedinPACE_Model2_z, meta_OMICmAge_Model2_z, meta_GrimAge_Model2_z,
                                source_names = c("meta_DunedinPACE_Model2_z", "meta_OMICmAge_Model2_z", "meta_GrimAge_Model2_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p2)
ggsave(filename = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/forest_plot_fusion_model2_z.png", plot = p2)



#Model3
p3 <- forestplot_fusion(meta_DunedinPACE_Model3_z, meta_OMICmAge_Model3_z, meta_GrimAge_Model3_z,
                                source_names = c("meta_DunedinPACE_Model3_z", "meta_OMICmAge_Model3_z", "meta_GrimAge_Model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p3)
ggsave(filename = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/forest_plot_fusion_model3_z.png", plot = p3)



