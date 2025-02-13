run_models_survey1 <- function(

  # The function will remove covariates that have p-values > 0.15 in model 1, and exclude them in model 2 and 3

  Anti_aging_interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
                     "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
                     "HRT", "spermidine"), 
                     covariates = c("Alcohol_per_week_numeric",  
                                    "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
                                    "Exercise.per.week_numeric", "Exercise.Type",
                                    "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", 
                                    "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"), 
                                    cov_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
                                    suffix = ""  # new parameter for file name suffix
                                    ) {
  # Import functions and libraries
  source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
  source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
  source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
  library(pacman)
  p_load(mice, ggplot2)
  
  # Load imputed survey1 data
  load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1")
  imp_data_surv1 <- imputed_data
  df1_imp_data_surv1 <- complete(imputed_data, 1)
  
  # Model 1 Supplement - Survey1
  interventions <- Anti_aging_interventions
  lifestyle_covariates_survey1 <- covariates
  covariates_to_always_include <- cov_to_always_include
  
  combined_results_df <- model_exposure_wise(
      path = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1", 
      outcome_vars = c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
      exposure_vars = c(interventions, lifestyle_covariates_survey1), 
      covariate_vars = covariates_to_always_include)
  
  p1 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_Survey1_plot", suffix, ".png"), plot = p1)
  
  p2 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model1_Survey1_plot", suffix, ".png"), plot = p2)
  
  p3 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model1_Survey1_plot", suffix, ".png"), plot = p3)
  
  DunedinPACE_Model1_Survey1 <- combined_results_df[["DunedinPACE"]]
  GrimAge_PCAgeDev_Model2_Survey1 <- combined_results_df[["GrimAge.PCAgeDev"]]
  OMICmAgeAgeDev_Model1_Survey1 <- combined_results_df[["OMICmAgeAgeDev"]]
  
  lifestyle_covariates_survey1_updated <- remove_terms_if_p_large(
    lifestyle_covariates_survey1, 
    categorical_variables_to_exclude = c("Main.Diet.Factor", "Exercise.Type"),
    list(DunedinPACE_Model1_Survey1, GrimAge_PCAgeDev_Model2_Survey1, OMICmAgeAgeDev_Model1_Survey1))
  
  interventions_large_p <- remove_terms_if_p_large(
    interventions, 
    list(DunedinPACE_Model1_Survey1, GrimAge_PCAgeDev_Model2_Survey1, OMICmAgeAgeDev_Model1_Survey1))
  
  # Model 1 SD - Survey1
  combined_results_df <- model_exposure_wise(
      path = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1", 
      outcome_vars = c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
      exposure_vars = c(interventions, lifestyle_covariates_survey1), 
      covariate_vars = covariates_to_always_include)
  
  DunedinPACE <- combined_results_df[["DunedinPACE_z"]]
  GrimAge <- combined_results_df[["GrimAge.PCAgeDev_z"]]
  OmicAge <- combined_results_df[["OMICmAgeAgeDev_z"]]
  
  fused_plot_model1 <- forestplot_fusion(DunedinPACE, GrimAge, OmicAge,
                                         source_names = c("DunedinPACE", "GrimAge", "OmicAge"),
                                         color_values = c("darkred", "navy", "forestgreen"),
                                         ylab ="Term", xlab = "SD", plot_size = 14)
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/fused_Model1SD_Survey1_plot", suffix, ".png"), plot = fused_plot_model1)
  
  # Model 2 - Survey1
  covariates_to_always_include <- c("Decimal.Chronological.Age", "Biological.Sex", lifestyle_covariates_survey1_updated)
  combined_results_df <- model_exposure_wise(
      path = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1", 
      outcome_vars = c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
      exposure_vars = interventions_large_p, 
      covariate_vars = covariates_to_always_include)
  
  p4 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_Survey1_plot", suffix, ".png"), plot = p4)
  
  p5 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model2_Survey1_plot", suffix, ".png"), plot = p5)
  
  p6 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model2_Survey1_plot", suffix, ".png"), plot = p6)
  
  DunedinPACE_Model2_Survey1 <- combined_results_df[["DunedinPACE"]]
  GrimAge_PCAgeDev_Model2_Survey1 <- combined_results_df[["GrimAge.PCAgeDev"]]
  OMICmAgeAgeDev_Model2_Survey1 <- combined_results_df[["OMICmAgeAgeDev"]]
  
  # Model 2 SD - Survey1
  combined_results_df <- model_exposure_wise(
      path = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1", 
      outcome_vars = c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
      exposure_vars = interventions_large_p, 
      covariate_vars = covariates_to_always_include)
  
  DunedinPACE <- combined_results_df[["DunedinPACE_z"]]
  GrimAge <- combined_results_df[["GrimAge.PCAgeDev_z"]]
  OmicAge <- combined_results_df[["OMICmAgeAgeDev_z"]]
  
  fused_plot_model2 <- forestplot_fusion(DunedinPACE, GrimAge, OmicAge,
                                         source_names = c("DunedinPACE", "GrimAge", "OmicAge"),
                                         color_values = c("darkred", "navy", "forestgreen"),
                                         ylab ="Term", xlab = "SD")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/fused_Model2SD_Survey1_plot", suffix, ".png"), plot = fused_plot_model2)
  
  # Model 3 - Survey1
  model3_DunedinPACE <- fit_imputed_lm(imp_data_surv1, outcome = "DunedinPACE", exposures = interventions_large_p, covariates = covariates_to_always_include)
  DunedinPACE <- subset(model3_DunedinPACE, term %in% interventions_large_p)
  p7 <- plot_forest(DunedinPACE, ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_Survey1_plot", suffix, ".png"), plot = p7)
  
  model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data_surv1, outcome = "GrimAge.PCAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
  GrimAge <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
  p8 <- plot_forest(GrimAge, ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/GrimAge_PCAgeDev_Model3_Survey1_plot", suffix, ".png"), plot = p8)
  
  model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data_surv1, outcome = "OMICmAgeAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
  OmicAge <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
  p9 <- plot_forest(OmicAge, ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/OMICmAgeAgeDev_Model3_Survey1_plot", suffix, ".png"), plot = p9)
  
  # Model 3 SD - Survey1
  model3_DunedinPACE <- fit_imputed_lm(imp_data_surv1, outcome = "DunedinPACE_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
  DunedinPACE <- subset(model3_DunedinPACE, term %in% interventions_large_p)
  
  model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data_surv1, outcome = "GrimAge.PCAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
  GrimAge <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
  
  model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data_surv1, outcome = "OMICmAgeAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
  OmicAge <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
  
  fused_plot_model3 <- forestplot_fusion(DunedinPACE, GrimAge, OmicAge,
                                         source_names = c("DunedinPACE", "GrimAge", "OmicAge"),
                                         color_values = c("darkred", "navy", "forestgreen"),
                                         ylab ="Term", xlab = "SD")
  ggsave(paste0("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/fused_Model3_Survey1_plot", suffix, ".png"), plot = fused_plot_model3)
  
  # (Optionally, return key model results)
  return(invisible(list(
    Model1 = list(DunedinPACE = DunedinPACE_Model1_Survey1,
                  GrimAge = GrimAge_PCAgeDev_Model2_Survey1,
                  OMIC = OMICmAgeAgeDev_Model1_Survey1),
    Model2 = list(DunedinPACE = DunedinPACE_Model2_Survey1,
                  GrimAge = GrimAge_PCAgeDev_Model2_Survey1,
                  OMIC = OMICmAgeAgeDev_Model2_Survey1)
  )))
}

if (interactive()) {
  run_models_survey1()
}

