library(pacman)
p_load(mice)

# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/MetaAnalyse().R")
# source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")



main_models <- function(interventions_surv1, interventions_surv2, interventions_surv3, lifestyle_covariates_surv_1, lifestyle_covariates_surv_2, lifestyle_covariates_surv_3, base_path, p_filter_subjects= "write p-filter subjects: options are 'all', 'only_lifestyle_covariates', 'none'") {
  

  # Print the base path
  print(paste("Base path is:", base_path))
  
  # Print the p_filter_subjects
  print(paste("p_filter_subjects is:", p_filter_subjects))


# Generate main models
print("Generate main models")

# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey1_all_participants"))
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
  interventions = interventions_surv1,
  lifestyle_covariates = lifestyle_covariates_surv_1,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex"),
  imp_data = imp_data_surv1,
  savePath = paste0(base_path, "Output/main_models_results/"),
  suffix = "_survey1_main.xlsx",
  save_raw_excel = TRUE,
  p_filter = p_filter_subjects
) 

print("Generate main models for surv 2")

# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey2_all_participants"))
#rename object
imp_data_surv2 <- imputed_data
df1_imp_data_surv2<-complete(imputed_data, 1)


results_surv2<-run_models(
  interventions = interventions_surv2,
  lifestyle_covariates = lifestyle_covariates_surv_2,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv2,
  savePath = paste0(base_path, "Output/main_models_results/"),
  suffix = "_survey2_main.xlsx",
  save_raw_excel = TRUE,
  p_filter = p_filter_subjects) 


print("Generate main models for surv 3")

# Load corresponding data
load(paste0(base_path, "Output/imputation_results/imputed_survey3_all_participants"))
#rename object
imp_data_surv3 <- imputed_data
df1_imp_data_surv3<-complete(imputed_data, 1)
# print(colnames(df1_imp_data_surv3))


results_surv3<-run_models(
  interventions = interventions_surv3,
  lifestyle_covariates = lifestyle_covariates_surv_3,
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv3,
  savePath = paste0(base_path, "Output/main_models_results/"),
  suffix = "_survey3_main.xlsx",
  save_raw_excel = TRUE,
  p_filter = p_filter_subjects) 



print("Generating meta analysis for raw models")

#Run meta models for raw
meta_model1_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$DunedinPACE_model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$DunedinPACE_model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$DunedinPACE_model1, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "DunedinPACE_model1")

meta_model1_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$OMICmAgeAgeDev_model1, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "OMICmAgeAgeDev_model1")

meta_model1_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_model1, 
    survey2 = results_surv2$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_model1, 
    survey3 = results_surv3$surv_results_raw$surv_results_model1_raw$GrimAge_PCAgeDev_model1, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "GrimAge_PCAgeDev_model1")

#Run models for model 2 raw
meta_model2_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model2_raw$DunedinPACE_model2, 
    survey2 = results_surv2$surv_results_raw$surv_results_model2_raw$DunedinPACE_model2, 
    survey3 = results_surv3$surv_results_raw$surv_results_model2_raw$DunedinPACE_model2, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "DunedinPACE_model2")

meta_model2_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model2_raw$OMICmAgeAgeDev_model2, 
    survey2 = results_surv2$surv_results_raw$surv_results_model2_raw$OMICmAgeAgeDev_model2, 
    survey3 = results_surv3$surv_results_raw$surv_results_model2_raw$OMICmAgeAgeDev_model2, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "OMICmAgeAgeDev_model2")

meta_model2_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model2_raw$GrimAge_PCAgeDev_model2, 
    survey2 = results_surv2$surv_results_raw$surv_results_model2_raw$GrimAge_PCAgeDev_model2, 
    survey3 = results_surv3$surv_results_raw$surv_results_model2_raw$GrimAge_PCAgeDev_model2, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "GrimAge_PCAgeDev_model2")

#Run models for model 3 raw
meta_model3_DunedinPACE<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model3_raw$DunedinPACE_model3, 
    survey2 = results_surv2$surv_results_raw$surv_results_model3_raw$DunedinPACE_model3, 
    survey3 = results_surv3$surv_results_raw$surv_results_model3_raw$DunedinPACE_model3, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "DunedinPACE_model3")

meta_model3_OMICmAgeAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model3_raw$OMICmAgeAgeDev_model3, 
    survey2 = results_surv2$surv_results_raw$surv_results_model3_raw$OMICmAgeAgeDev_model3, 
    survey3 = results_surv3$surv_results_raw$surv_results_model3_raw$OMICmAgeAgeDev_model3, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "OMICmAgeAgeDev_model3")

meta_model3_GrimAge_PCAgeDev<-MetaAnalyse(
    survey1 = results_surv1$surv_results_raw$surv_results_model3_raw$GrimAge_PCAgeDev_model3, 
    survey2 = results_surv2$surv_results_raw$surv_results_model3_raw$GrimAge_PCAgeDev_model3, 
    survey3 = results_surv3$surv_results_raw$surv_results_model3_raw$GrimAge_PCAgeDev_model3, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "GrimAge_PCAgeDev_model3")



#PLOT 
#model1 RAW 
# Create plot for DunedinPACE raw
plot_forest(meta_model1_DunedinPACE, estimate_col = "Estimate", conf.low_col = "lower_CI", 
conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
xlab = "Biological year per chronological year", ylab = "Term", vertical_line = 0, plot_title = "meta_model1_DunedinPACE_raw", 
savePath = paste0(base_path, "Output/main_models_results/meta_model1_DunedinPACE_raw.png"))
# Create plot for OMICmAgeAgeDev raw
plot_forest(meta_model1_OMICmAgeAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI", 
conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model1_OMICmAgeAgeDev_raw",
savePath = paste0(base_path, "Output/main_models_results/meta_model1_OMICmAgeAgeDev_raw.png"))
# Create plot for GrimAgeAgeDev raw
plot_forest(meta_model1_GrimAge_PCAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI", 
conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model1_GrimAge_PCAgeDev_raw",
savePath = paste0(base_path, "Output/main_models_results/meta_model1_GrimAge_PCAgeDev_raw.png"))


#PLOT model2 RAW
# Create plot for DunedinPACE sd
plot_forest(meta_model2_DunedinPACE, estimate_col = "Estimate", conf.low_col = "lower_CI",
 conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
 xlab = "Biological year per chronological year", ylab = "Term", vertical_line = 0, plot_title = "meta_model2_DunedinPACE_raw",
  savePath = paste0(base_path, "Output/main_models_results/meta_model2_DunedinPACE_raw.png"))
# Create plot for OMICmAgeAgeDev raw
plot_forest(meta_model2_OMICmAgeAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model2_OMICmAgeAgeDev_raw",
  savePath = paste0(base_path, "Output/main_models_results/meta_model2_OMICmAgeAgeDev_raw.png"))
# Create plot for GrimAgeAgeDev raw
plot_forest(meta_model2_GrimAge_PCAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model2_GrimAge_PCAgeDev_raw",
  savePath = paste0(base_path, "Output/main_models_results/meta_model2_GrimAge_PCAgeDev_raw.png"))

#PLOT model3 RAW
# Create plot for DunedinPACE raw
plot_forest(meta_model3_DunedinPACE, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "", ylab = "", vertical_line = 0, plot_title = "meta_model3_DunedinPACE_raw",
  savePath = paste0(base_path, "Output/main_models_results/meta_model3_DunedinPACE_raw.png"))
# Create plot for OMICmAgeAgeDev raw
plot_forest(meta_model3_OMICmAgeAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model3_OMICmAgeAgeDev_raw",
  savePath = paste0(base_path, "Output/main_models_results/meta_model3_OMICmAgeAgeDev_raw.png"))
# Create plot for GrimAgeAgeDev raw
plot_forest(meta_model3_GrimAge_PCAgeDev, estimate_col = "Estimate", conf.low_col = "lower_CI",
  conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", 
  xlab = "AgeDev (years)", ylab = "Term", vertical_line = 0, plot_title = "meta_model3_GrimAge_PCAgeDev_raw",
  savePath = paste0(base_path, "Output/main_models_results/meta_model3_GrimAge_PCAgeDev_raw.png"))


#Create meta analysis for SD versions of biomarkers

print("Generating meta analysis for SD models")


#Run meta models for model 1 sd
meta_DunedinPACE_model1_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model1_sd$DunedinPACE_model1_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model1_sd$DunedinPACE_model1_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model1_sd$DunedinPACE_model1_z, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "DunedinPACE_model1_z")

meta_OMICmAge_model1_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model1_sd$OMICmAge_model1_z,
    survey2 = results_surv2$surv_results_sd$surv_results_model1_sd$OMICmAge_model1_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model1_sd$OMICmAge_model1_z, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "OMICmAge_model1_z")

meta_GrimAge_model1_z<-MetaAnalyse(  
    survey1 = results_surv1$surv_results_sd$surv_results_model1_sd$GrimAge_model1_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model1_sd$GrimAge_model1_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model1_sd$GrimAge_model1_z,
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "GrimAge_PC_model1_z")

#Run meta models for model 2 sd
meta_DunedinPACE_model2_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model2_sd$DunedinPACE_model2_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model2_sd$DunedinPACE_model2_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model2_sd$DunedinPACE_model2_z, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "DunedinPACE_model2_z")

meta_OMICmAge_model2_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model2_sd$OMICmAge_model2_z,
    survey2 = results_surv2$surv_results_sd$surv_results_model2_sd$OMICmAge_model2_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model2_sd$OMICmAge_model2_z, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "OMICmAge_model2_z")

meta_GrimAge_model2_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model2_sd$GrimAge_model2_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model2_sd$GrimAge_model2_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model2_sd$GrimAge_model2_z,
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "GrimAge_PC_model2_z")

#Run meta models for model 3 sd
meta_DunedinPACE_model3_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "DunedinPACE_model3_z")

meta_OMICmAge_model3_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
    survey2 = results_surv2$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z, 
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "OMICmAge_model3_z")

meta_GrimAge_model3_z<-MetaAnalyse(
    survey1 = results_surv1$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z, 
    survey2 = results_surv2$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
    survey3 = results_surv3$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
    savePath = paste0(base_path, "Output/main_models_results/"), 
    model_name = "GrimAge_PC_model3_z")



#Creat fused forest plot for SD models

# model1
# Save meta-analysis tables
model1_meta<- rbind(meta_DunedinPACE_model1_z, meta_OMICmAge_model1_z, meta_GrimAge_model1_z)
write_xlsx(model1_meta, paste0(base_path, "Output/main_models_results/", "meta_model1_z_table.xlsx"))

p1 <- forestplot_fusion(meta_DunedinPACE_model1_z, meta_OMICmAge_model1_z, meta_GrimAge_model1_z,
                                source_names = c("meta_DunedinPACE_model1_z", "meta_OMICmAge_model1_z", "meta_GrimAge_model1_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p1)
ggsave(filename = paste0(base_path, "Output/main_models_results/forest_plot_fusion_model1_z.png"), plot = p1)


#model2
# Save meta-analysis tables
model2_meta<- rbind(meta_DunedinPACE_model2_z, meta_OMICmAge_model2_z, meta_GrimAge_model2_z)
write_xlsx(model2_meta, paste0(base_path, "Output/main_models_results/", "meta_model2_z_table.xlsx"))

p2 <- forestplot_fusion(meta_DunedinPACE_model2_z, meta_OMICmAge_model2_z, meta_GrimAge_model2_z,
                                source_names = c("meta_DunedinPACE_model2_z", "meta_OMICmAge_model2_z", "meta_GrimAge_model2_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p2)
ggsave(filename = paste0(base_path, "Output/main_models_results/forest_plot_fusion_model2_z.png"), plot = p2)



#model3
# Save meta-analysis tables
model3_meta<- rbind(meta_DunedinPACE_model3_z, meta_OMICmAge_model3_z, meta_GrimAge_model3_z)
write_xlsx(model3_meta, paste0(base_path, "Output/main_models_results/", "meta_model3_z_table.xlsx"))


p3 <- forestplot_fusion(meta_DunedinPACE_model3_z, meta_OMICmAge_model3_z, meta_GrimAge_model3_z,
                                source_names = c("meta_DunedinPACE_model3_z", "meta_OMICmAge_model3_z", "meta_GrimAge_model3_z"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL)
print(p3)
ggsave(filename = paste0(base_path, "Output/main_models_results/forest_plot_fusion_model3_z.png"), plot = p3)

  #Package all results which the function will return
  surv1 <- list(
      interventions_small_p = results_surv1$interventions_small_p,
      lifestyle_covariates_updated = results_surv1$lifestyle_covariates_updated
  )

  surv2 <- list(
      interventions_small_p = results_surv2$interventions_small_p,
      lifestyle_covariates_updated = results_surv2$lifestyle_covariates_updated
  )
  
  surv3 <- list(
      interventions_small_p = results_surv3$interventions_small_p,
      lifestyle_covariates_updated = results_surv3$lifestyle_covariates_updated
  )

  p_filter_results <- list(
    surv1 = surv1,
    surv2 = surv2,
    surv3 = surv3
  )
  
  return(p_filter_results)

}

