
run_models <- function(imp_data,
interventions = NULL,
lifestyle_covariates = NULL,
covariates_to_always_include = NULL,
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
suffix = "_survey_and_model_not_specified") {
  
  
  # Check that the column values are compatible with analysis
  inspect_columns(complete(imp_data, 1), c(interventions, lifestyle_covariates, covariates_to_always_include))
  
  # Run model1 to select significant variables
  print("Run model1 to select significant variables")
  combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                             outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
                                             exposure_vars=c(interventions, lifestyle_covariates), 
                                             covariate_vars=covariates_to_always_include)
  
    # Save plots for DunedinPACE, GrimAge.PCAgeDev and OMICmAgeAgeDev
    # p1 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = " Aging Pace (biological year/chronological year)")
    # ggsave(paste0(savePath,"DunedinPACE_Model1_plot", suffix, ".png"), plot = p1)
    # p2 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model1_plot", suffix, ".png"), plot = p2)
    # p3 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # ggsave(paste0(savePath,"OMICmAgeAgeDev_Model1_plot", suffix, ".png"), plot = p3)
  
  # Save dataframes
  DunedinPACE_Model1 <- combined_results_df[["DunedinPACE"]]
  save(DunedinPACE_Model1, file = paste0(savePath,"DunedinPACE_Model1", suffix))
  GrimAge_PCAgeDev_Model1 <- combined_results_df[["GrimAge.PCAgeDev"]]
  save(GrimAge_PCAgeDev_Model1, file = paste0(savePath,"GrimAge_PCAgeDev_Model1", suffix))
  OMICmAgeAgeDev_Model1 <- combined_results_df[["OMICmAgeAgeDev"]]
  save(OMICmAgeAgeDev_Model1, file = paste0(savePath,"OMICmAgeAgeDev_Model1", suffix))
  
  lifestyle_covariates_updated <- remove_terms_if_p_large(
    lifestyle_covariates, categorical_variables_to_exclude=c("Main.Diet.Factor", "Exercise.Type"),
    list(DunedinPACE_Model1, GrimAge_PCAgeDev_Model1, OMICmAgeAgeDev_Model1))
  
  interventions_large_p <- remove_terms_if_p_large(
    interventions, 
    list(DunedinPACE_Model1, GrimAge_PCAgeDev_Model1, OMICmAgeAgeDev_Model1))
  
  ### Model 1 SD 
    print("Run Model 1 SD ")
    combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                               outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
                                               exposure_vars=c(interventions, lifestyle_covariates), 
                                               covariate_vars=covariates_to_always_include)
    DunedinPACE_Model1_z <- combined_results_df[["DunedinPACE_z"]]
    save(DunedinPACE_Model1_z, file = paste0(savePath,"DunedinPACE_Model1_z", suffix))
    GrimAge_Model1_z <- combined_results_df[["GrimAge.PCAgeDev_z"]]
    save(GrimAge_Model1_z, file = paste0(savePath,"GrimAge_Model1_z", suffix))
    OMICmAge_Model1_z <- combined_results_df[["OMICmAgeAgeDev_z"]]
    save(OMICmAge_Model1_z, file = paste0(savePath,"OMICmAge_Model1_z", suffix))
    # fused_plot_model1 <- forestplot_fusion(DunedinPACE_Model1_z,
    #                                        GrimAge_Model1_z,
    #                                        OMICmAge_Model1_z,
    #                                        source_names = c("DunedinPACE_Model1_z", "GrimAge_Model1_z", "OMICmAge_Model1_z"),
    #                                        color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")
    # ggsave(paste0(savePath,"fused_Model1SD_plot", suffix, ".png"), plot = fused_plot_model1)
  
  
  ### Model 2 
  covariates_to_always_include <- c(covariates_to_always_include, lifestyle_covariates_updated)
    print("Run Model 2")
    combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                               outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
                                               exposure_vars=interventions_large_p, 
                                               covariate_vars=covariates_to_always_include)
    # p4 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
    # ggsave(paste0(savePath,"DunedinPACE_Model2_plot", suffix, ".png"), plot = p4)
    # p5 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model2_plot", suffix, ".png"), plot = p5)
    # p6 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # ggsave(paste0(savePath,"OMICmAgeAgeDev_Model2_plot", suffix, ".png"), plot = p6)
    DunedinPACE_Model2 <- combined_results_df[["DunedinPACE"]]
    save(DunedinPACE_Model2, file = paste0(savePath,"DunedinPACE_Model2", suffix))
    GrimAge_PCAgeDev_Model2 <- combined_results_df[["GrimAge.PCAgeDev"]]
    save(GrimAge_PCAgeDev_Model2, file = paste0(savePath,"GrimAge_PCAgeDev_Model2", suffix))
    OMICmAgeAgeDev_Model2 <- combined_results_df[["OMICmAgeAgeDev"]]
    save(OMICmAgeAgeDev_Model2, file = paste0(savePath,"OMICmAgeAgeDev_Model2", suffix))
  
  
  ### Model 2 SD 
    print("Run Model 2 SD")
    combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                               outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
                                               exposure_vars=interventions_large_p, 
                                               covariate_vars=covariates_to_always_include)
    DunedinPACE_Model2_z <- combined_results_df[["DunedinPACE_z"]]
    save(DunedinPACE_Model2_z, file = paste0(savePath,"DunedinPACE_Model2_z", suffix))
    GrimAge_Model2_z <- combined_results_df[["GrimAge.PCAgeDev_z"]]
    save(GrimAge_Model2_z, file = paste0(savePath,"GrimAge_Model2_z", suffix))
    OMICmAge_Model2_z <- combined_results_df[["OMICmAgeAgeDev_z"]]
    save(OMICmAge_Model2_z, file = paste0(savePath,"OMICmAge_Model2_z", suffix))
    # fused_plot_model2 <- forestplot_fusion(DunedinPACE_Model2_z,
    #                                        GrimAge_Model2_z,
    #                                        OMICmAge_Model2_z,
    #                                        source_names = c("DunedinPACE_Model2_z", "GrimAge_Model2_z", "OMICmAge_Model2_z"),
    #                                        color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")
    # ggsave(paste0(savePath,"fused_Model2SD_plot", suffix, ".png"), plot = fused_plot_model2)
  
  
  ### Model 3
    print("Run Model 3")
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE", exposures = interventions_large_p, covariates = covariates_to_always_include)
    DunedinPACE_Model3 <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    save(DunedinPACE_Model3, file = paste0(savePath,"DunedinPACE_Model3", suffix))
    # p7 <- plot_forest(DunedinPACE_Model3, ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
    # ggsave(paste0(savePath,"DunedinPACE_Model3_plot", suffix, ".png"), plot = p7)
    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    GrimAge_PCAgeDev_Model3 <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    save(GrimAge_PCAgeDev_Model3, file = paste0(savePath,"GrimAge_PCAgeDev_Model3", suffix))
    # p8 <- plot_forest(GrimAge_PCAgeDev_Model3, ylab ="Term", xlab = "Age Deviation (years)")
    # ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model3_plot", suffix, ".png"), plot = p8)
    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    OMICmAgeAgeDev_Model3 <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    save(OMICmAgeAgeDev_Model3, file = paste0(savePath,"OMICmAgeAgeDev_Model3", suffix))
    # p9 <- plot_forest(OMICmAgeAgeDev_Model3, ylab ="Term", xlab = "Age Deviation (years)")
    # ggsave(paste0(savePath,"OMICmAgeAgeDev_Model3_plot", suffix, ".png"), plot = p9)
  
  
  ### Model 3 SD
    print("Run Model 3 SD")
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    DunedinPACE_Model3_z <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    save(DunedinPACE_Model3_z, file = paste0(savePath,"DunedinPACE_Model3_z", suffix))
    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    GrimAge_Model3_z <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    save(GrimAge_Model3_z, file = paste0(savePath,"GrimAge_Model3_z", suffix))
    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    OMICmAge_Model3_z <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    save(OMICmAge_Model3_z, file = paste0(savePath,"OMICmAge_Model3_z", suffix))
    # fused_plot_model3 <- forestplot_fusion(DunedinPACE_Model3_z,
    #                                        GrimAge_Model3_z,
    #                                        OMICmAge_Model3_z,
    #                                        source_names = c("DunedinPACE_Model3_z", "GrimAge_Model3_z", "OMICmAge_Model3_z"),
    #                                        color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")
    # ggsave(paste0(savePath,"fused_Model3_plot", suffix, ".png"), plot = fused_plot_model3)
  
  
  #Package raw results
  surv_results_model1_raw <- list(
      DunedinPACE_Model1 = DunedinPACE_Model1,
      GrimAge_PCAgeDev_Model1 = GrimAge_PCAgeDev_Model1,
      OMICmAgeAgeDev_Model1 = OMICmAgeAgeDev_Model1
  )
  surv_results_model2_raw <- list(
      DunedinPACE_Model2 = DunedinPACE_Model2,
      GrimAge_PCAgeDev_Model2 = GrimAge_PCAgeDev_Model2,
      OMICmAgeAgeDev_Model2 = OMICmAgeAgeDev_Model2
  )
  surv_results_model3_raw <- list(
      DunedinPACE_Model3 = DunedinPACE_Model3,
      GrimAge_PCAgeDev_Model3 = GrimAge_PCAgeDev_Model3,
      OMICmAgeAgeDev_Model3 = OMICmAgeAgeDev_Model3
  )
  surv_results_raw <- list(
      surv_results_model1_raw = surv_results_model1_raw,
      surv_results_model2_raw = surv_results_model2_raw,
      surv_results_model3_raw = surv_results_model3_raw
  )
  
  #Package SD results
  surv_results_model1_sd <- list(
      DunedinPACE_Model1_z = DunedinPACE_Model1_z,
      GrimAge_Model1_z = GrimAge_Model1_z,
      OMICmAge_Model1_z = OMICmAge_Model1_z
  )
  surv_results_model2_sd <- list(
      DunedinPACE_Model2_z = DunedinPACE_Model2_z,
      GrimAge_Model2_z = GrimAge_Model2_z,
      OMICmAge_Model2_z = OMICmAge_Model2_z
  )
  surv_results_model3_sd <- list(
      DunedinPACE_Model3_z = DunedinPACE_Model3_z,
      GrimAge_Model3_z = GrimAge_Model3_z,
      OMICmAge_Model3_z = OMICmAge_Model3_z
  )
  surv_results_sd <- list(
      surv_results_model1_sd = surv_results_model1_sd,
      surv_results_model2_sd = surv_results_model2_sd,
      surv_results_model3_sd = surv_results_model3_sd
  )
  
  #Package all results which the function will return
  surv_results <- list(
      surv_results_raw = surv_results_raw,
      surv_results_sd = surv_results_sd
  )
  
  return(surv_results)
}