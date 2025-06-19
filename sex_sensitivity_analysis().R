library(pacman)
p_load(mice, writexl)



sex_sensitivity_analysis <- function(interventions_to_use, lifestyle_covariates_surv_1, lifestyle_covariates_surv_2, lifestyle_covariates_surv_3, base_path) {

  # SURVEY 1
  print("Generate sensitivity analysis for survey 1")
  
  # Generate sensitivity analysis for males
  print("Generate sensitivity analysis for males")
  
  # Load corresponding data
  load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_males"))
  #rename object
  imputed_survey1_only_males <- imputed_data
  df1_imputed_survey1_only_males<-complete(imputed_data, 1)
  
  results_only_males_survey1<-run_models(
    interventions = interventions_to_use,
    lifestyle_covariates = lifestyle_covariates_surv_1,
    covariates_to_always_include=c("Decimal.Chronological.Age"),
    imp_data = imputed_survey1_only_males,
    savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"),
    suffix = "_only_males_survey1.xlsx")
  
  
  # Generate sensitivity analysis for females
  print("Generate sensitivity analysis for females")
  # Load corresponding data
  load(paste0(base_path, "Output/imputation_results/imputed_survey1_only_females"))
  #rename object
  imputed_survey1_only_females <- imputed_data
  df1_imputed_survey1_only_females<-complete(imputed_data, 1)
  
  results_only_females_survey1<-run_models(
    interventions = interventions_to_use,
    lifestyle_covariates = lifestyle_covariates_surv_1,
    covariates_to_always_include=c("Decimal.Chronological.Age"),
    imp_data = imputed_survey1_only_females,
    savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"),
    suffix = "_only_females_survey1.xlsx")
  
  
  #SURVEY 2
  print("Generate sensitivity analysis for survey 2")
  
  # Generate sensitivity analysis for males
  print("Generate sensitivity analysis for males")
  
  # Load corresponding data
  load(paste0(base_path, "Output/imputation_results/imputed_survey2_only_males"))
  #rename object
  imputed_survey2_only_males <- imputed_data
  df2_imputed_survey2_only_males<-complete(imputed_data, 2)
  
  results_only_males_survey2<-run_models(
    interventions = interventions_to_use,
    lifestyle_covariates = lifestyle_covariates_surv_2,
    covariates_to_always_include=c("Decimal.Chronological.Age"),
    imp_data = imputed_survey2_only_males,
    savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"),
    suffix = "_only_males_survey2.xlsx")
  
  
  # Generate sensitivity analysis for females
  print("Generate sensitivity analysis for females")
  # Load corresponding data
  load(paste0(base_path, "Output/imputation_results/imputed_survey2_only_females"))
  #rename object
  imputed_survey2_only_females <- imputed_data
  df2_imputed_survey2_only_females<-complete(imputed_data, 2)
  
  results_only_females_survey2<-run_models(
    interventions = interventions_to_use,
    lifestyle_covariates = lifestyle_covariates_surv_2,
    covariates_to_always_include=c("Decimal.Chronological.Age"),
    imp_data = imputed_survey2_only_females,
    savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"),
    suffix = "_only_females_survey2.xlsx")
  
  
  #SURVEY 3
  print("Generate sensitivity analysis for survey 3")
  
  # Generate sensitivity analysis for males
  print("Generate sensitivity analysis for males")
  
  # Load corresponding data
  load(paste0(base_path, "Output/imputation_results/imputed_survey3_only_males"))
  #rename object
  imputed_survey3_only_males <- imputed_data
  df3_imputed_survey3_only_males<-complete(imputed_data, 3)
  
  results_only_males_survey3<-run_models(
    interventions = interventions_to_use,
    lifestyle_covariates = lifestyle_covariates_surv_3,
    covariates_to_always_include=c("Decimal.Chronological.Age"),
    imp_data = imputed_survey3_only_males,
    savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"),
    suffix = "_only_males_survey3.xlsx")
  
  
  # Generate sensitivity analysis for females
  print("Generate sensitivity analysis for females")
  # Load corresponding data
  load(paste0(base_path, "Output/imputation_results/imputed_survey3_only_females"))
  #rename object
  imputed_survey3_only_females <- imputed_data
  df3_imputed_survey3_only_females<-complete(imputed_data, 3)
  
  results_only_females_survey3<-run_models(
    interventions = interventions_to_use,
    lifestyle_covariates = lifestyle_covariates_surv_3,
    covariates_to_always_include=c("Decimal.Chronological.Age"),
    imp_data = imputed_survey3_only_females,
    savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"),
    suffix = "_only_females_survey3.xlsx")
  
  
  
  #GENERATE METAANALYSIS MALES
  #Create meta analysis for SD versions of biomarkers
  
  print("Generating meta analysis for SD models")
  
  #Run meta models for model 3 males
  meta_DunedinPACE_model3_z<-MetaAnalyse(
      survey1 = results_only_males_survey1$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
      survey2 = results_only_males_survey2$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z,
      survey3 = results_only_males_survey3$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
      savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"), 
      model_name = "DunedinPACE_model3_only_males_z")
  
  meta_OMICmAge_model3_z<-MetaAnalyse(
      survey1 = results_only_males_survey1$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
      survey2 = results_only_males_survey2$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
      survey3 = results_only_males_survey3$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z, 
      savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"), 
      model_name = "OMICmAge_model3_only_males_z")
  
  meta_GrimAge_model3_z<-MetaAnalyse(  
      survey1 = results_only_males_survey1$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z, 
      survey2 = results_only_males_survey2$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
      survey3 = results_only_males_survey3$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
      savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"), 
      model_name = "GrimAge_PC_model3_only_males_z")
  
  # Save meta-analysis tables males
  write_xlsx(meta_DunedinPACE_model3_z, paste0(base_path, "Output/sex_sensitivity_analysis/", "meta_DunedinPACE_model3_only_males_z_table.xlsx"))
  write_xlsx(meta_OMICmAge_model3_z, paste0(base_path, "Output/sex_sensitivity_analysis/", "meta_OMICmAge_model3_only_males_z_table.xlsx"))
  write_xlsx(meta_GrimAge_model3_z, paste0(base_path, "Output/sex_sensitivity_analysis/", "meta_GrimAge_model3_only_males_z_table.xlsx"))
  
  
  
  #Plot males
  p1 <- forestplot_fusion(meta_DunedinPACE_model3_z, meta_OMICmAge_model3_z, meta_GrimAge_model3_z,
                                  source_names = c("meta_DunedinPACE_model3_z", "meta_OMICmAge_model3_z", "meta_GrimAge_model3_z"),
                                  color_values = c("red", "blue", "green"),
                                  xlab = "", ylab = "", vertical_line = 0,
                                  plot_size = NULL)
  print(p1)
  ggsave(filename = paste0(base_path, "Output/sex_sensitivity_analysis/forest_plot_fusion_model3_only_males_z.png"), plot = p1)
  
  
  
  #Run meta models for model 3 females
  meta_DunedinPACE_model3_z<-MetaAnalyse(
      survey1 = results_only_females_survey1$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
      survey2 = results_only_females_survey2$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z,
      survey3 = results_only_females_survey3$surv_results_sd$surv_results_model3_sd$DunedinPACE_model3_z, 
      savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"), 
      model_name = "DunedinPACE_model3_only_females_z")
  
  meta_OMICmAge_model3_z<-MetaAnalyse(
      survey1 = results_only_females_survey1$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
      survey2 = results_only_females_survey2$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z,
      survey3 = results_only_females_survey3$surv_results_sd$surv_results_model3_sd$OMICmAge_model3_z, 
      savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"), 
      model_name = "OMICmAge_model3_only_females_z")
  
  meta_GrimAge_model3_z<-MetaAnalyse(
      survey1 = results_only_females_survey1$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z, 
      survey2 = results_only_females_survey2$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
      survey3 = results_only_females_survey3$surv_results_sd$surv_results_model3_sd$GrimAge_model3_z,
      savePath = paste0(base_path, "Output/sex_sensitivity_analysis/"), 
      model_name = "GrimAge_model3_only_females_z")
  
  
  # Save meta-analysis tables females
  write_xlsx(meta_DunedinPACE_model3_z, paste0(base_path, "Output/sex_sensitivity_analysis/", "meta_DunedinPACE_model3_only_females_z_table.xlsx"))
  write_xlsx(meta_OMICmAge_model3_z, paste0(base_path, "Output/sex_sensitivity_analysis/", "meta_OMICmAge_model3_only_females_z_table.xlsx"))
  write_xlsx(meta_GrimAge_model3_z, paste0(base_path, "Output/sex_sensitivity_analysis/", "meta_GrimAge_model3_only_females_z_table.xlsx"))
  
  
  #Plot females
  p2 <- forestplot_fusion(meta_DunedinPACE_model3_z, meta_OMICmAge_model3_z, meta_GrimAge_model3_z,
                                  source_names = c("meta_DunedinPACE_model3_z", "meta_OMICmAge_model3_z", "meta_GrimAge_model3_z"),
                                  color_values = c("red", "blue", "green"),
                                  xlab = "", ylab = "", vertical_line = 0,
                                  plot_size = NULL)
  print(p2)
  ggsave(filename = paste0(base_path, "Output/sex_sensitivity_analysis/forest_plot_fusion_model3_only_females_z.png"), plot = p2)
}

