library(writexl)



run_models <- function(imp_data,
interventions = NULL,
lifestyle_covariates = NULL,
covariates_to_always_include = NULL,
savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
suffix = "_survey_and_model_not_specified",
no_p_filter_metformin = FALSE) {
  
  
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
    # gg# save(paste0(savePath,"DunedinPACE_model1_plot", suffix, ".png"), plot = p1)
    # p2 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # gg# save(paste0(savePath,"GrimAge_PCAgeDev_model1_plot", suffix, ".png"), plot = p2)
    # p3 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # gg# save(paste0(savePath,"OMICmAgeAgeDev_model1_plot", suffix, ".png"), plot = p3)
  
  # Save dataframes
  DunedinPACE_model1 <- combined_results_df[["DunedinPACE"]]
  # write_xlsx(DunedinPACE_model1, paste0(savePath,"DunedinPACE_model1", suffix))
  GrimAge_PCAgeDev_model1 <- combined_results_df[["GrimAge.PCAgeDev"]]
  # write_xlsx(GrimAge_PCAgeDev_model1, paste0(savePath,"GrimAge_PCAgeDev_model1", suffix))
  OMICmAgeAgeDev_model1 <- combined_results_df[["OMICmAgeAgeDev"]]
  # write_xlsx(OMICmAgeAgeDev_model1, paste0(savePath,"OMICmAgeAgeDev_model1", suffix))
  
  if(no_p_filter_metformin== TRUE) {
  lifestyle_covariates_updated <- remove_terms_if_p_large(
    lifestyle_covariates,
    list(DunedinPACE_model1, GrimAge_PCAgeDev_model1, OMICmAgeAgeDev_model1))
  
  interventions_large_p <- remove_terms_if_p_large(
    interventions, variables_to_exclude = c("Metformin_new"),
    list(DunedinPACE_model1, GrimAge_PCAgeDev_model1, OMICmAgeAgeDev_model1))
  
  }
  else {
  lifestyle_covariates_updated <- remove_terms_if_p_large(
    lifestyle_covariates,
    list(DunedinPACE_model1, GrimAge_PCAgeDev_model1, OMICmAgeAgeDev_model1))
  
  interventions_large_p <- remove_terms_if_p_large(
    interventions, 
    list(DunedinPACE_model1, GrimAge_PCAgeDev_model1, OMICmAgeAgeDev_model1))
  }

  ### model 1 SD 
    print("Run model 1 SD ")
    combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                               outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
                                               exposure_vars=c(interventions, lifestyle_covariates), 
                                               covariate_vars=covariates_to_always_include)
    DunedinPACE_model1_z <- combined_results_df[["DunedinPACE_z"]]
    # write_xlsx(DunedinPACE_model1_z, paste0(savePath,"DunedinPACE_model1_z", suffix))
    GrimAge_model1_z <- combined_results_df[["GrimAge.PCAgeDev_z"]]
    # write_xlsx(GrimAge_model1_z, paste0(savePath,"GrimAge_model1_z", suffix))
    OMICmAge_model1_z <- combined_results_df[["OMICmAgeAgeDev_z"]]
    # write_xlsx(OMICmAge_model1_z, paste0(savePath,"OMICmAge_model1_z", suffix))
    # fused_plot_model1 <- forestplot_fusion(DunedinPACE_model1_z,
    #                                        GrimAge_model1_z,
    #                                        OMICmAge_model1_z,
    #                                        source_names = c("DunedinPACE_model1_z", "GrimAge_model1_z", "OMICmAge_model1_z"),
    #                                        color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")
    # gg# save(paste0(savePath,"fused_model1SD_plot", suffix, ".png"), plot = fused_plot_model1)
  
  
  ### model 2 
  covariates_to_always_include <- c(covariates_to_always_include, lifestyle_covariates_updated)
    print("Run model 2")
    combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                               outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
                                               exposure_vars=interventions_large_p, 
                                               covariate_vars=covariates_to_always_include)
    # p4 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
    # gg# save(paste0(savePath,"DunedinPACE_model2_plot", suffix, ".png"), plot = p4)
    # p5 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # gg# save(paste0(savePath,"GrimAge_PCAgeDev_model2_plot", suffix, ".png"), plot = p5)
    # p6 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    # gg# save(paste0(savePath,"OMICmAgeAgeDev_model2_plot", suffix, ".png"), plot = p6)
    DunedinPACE_model2 <- combined_results_df[["DunedinPACE"]]
    # write_xlsx(DunedinPACE_model2, paste0(savePath,"DunedinPACE_model2", suffix))
    GrimAge_PCAgeDev_model2 <- combined_results_df[["GrimAge.PCAgeDev"]]
    # write_xlsx(GrimAge_PCAgeDev_model2, paste0(savePath,"GrimAge_PCAgeDev_model2", suffix))
    OMICmAgeAgeDev_model2 <- combined_results_df[["OMICmAgeAgeDev"]]
    # write_xlsx(OMICmAgeAgeDev_model2, paste0(savePath,"OMICmAgeAgeDev_model2", suffix))
  
  
  ### model 2 SD 
    print("Run model 2 SD")
    combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                               outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
                                               exposure_vars=interventions_large_p, 
                                               covariate_vars=covariates_to_always_include)
    DunedinPACE_model2_z <- combined_results_df[["DunedinPACE_z"]]
    # write_xlsx(DunedinPACE_model2_z, paste0(savePath,"DunedinPACE_model2_z", suffix))
    GrimAge_model2_z <- combined_results_df[["GrimAge.PCAgeDev_z"]]
    # write_xlsx(GrimAge_model2_z, paste0(savePath,"GrimAge_model2_z", suffix))
    OMICmAge_model2_z <- combined_results_df[["OMICmAgeAgeDev_z"]]
    # write_xlsx(OMICmAge_model2_z, paste0(savePath,"OMICmAge_model2_z", suffix))
    # fused_plot_model2 <- forestplot_fusion(DunedinPACE_model2_z,
    #                                        GrimAge_model2_z,
    #                                        OMICmAge_model2_z,
    #                                        source_names = c("DunedinPACE_model2_z", "GrimAge_model2_z", "OMICmAge_model2_z"),
    #                                        color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")
    # gg# save(paste0(savePath,"fused_model2SD_plot", suffix, ".png"), plot = fused_plot_model2)
  
  
  ### model 3
    print("Run model 3")
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE", exposures = interventions_large_p, covariates = covariates_to_always_include)
    DunedinPACE_model3 <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    # write_xlsx(DunedinPACE_model3, paste0(savePath,"DunedinPACE_model3", suffix))
    # p7 <- plot_forest(DunedinPACE_model3, ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
    # gg# save(paste0(savePath,"DunedinPACE_model3_plot", suffix, ".png"), plot = p7)
    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    GrimAge_PCAgeDev_model3 <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    # write_xlsx(GrimAge_PCAgeDev_model3, paste0(savePath,"GrimAge_PCAgeDev_model3", suffix))
    # p8 <- plot_forest(GrimAge_PCAgeDev_model3, ylab ="Term", xlab = "Age Deviation (years)")
    # gg# save(paste0(savePath,"GrimAge_PCAgeDev_model3_plot", suffix, ".png"), plot = p8)
    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    OMICmAgeAgeDev_model3 <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    # write_xlsx(OMICmAgeAgeDev_model3, paste0(savePath,"OMICmAgeAgeDev_model3", suffix))
    # p9 <- plot_forest(OMICmAgeAgeDev_model3, ylab ="Term", xlab = "Age Deviation (years)")
    # gg# save(paste0(savePath,"OMICmAgeAgeDev_model3_plot", suffix, ".png"), plot = p9)
  
  
  ### model 3 SD
    print("Run model 3 SD")
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    DunedinPACE_model3_z <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    # write_xlsx(model3_DunedinPACE, paste0(savePath,"DunedinPACE_model3_z", suffix))
    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    GrimAge_model3_z <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    # write_xlsx(GrimAge_model3_z, paste0(savePath,"GrimAge_model3_z", suffix))
    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    OMICmAge_model3_z <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    # write_xlsx(OMICmAge_model3_z, paste0(savePath,"OMICmAge_model3_z", suffix))
    # fused_plot_model3 <- forestplot_fusion(DunedinPACE_model3_z,
    #                                        GrimAge_model3_z,
    #                                        OMICmAge_model3_z,
    #                                        source_names = c("DunedinPACE_model3_z", "GrimAge_model3_z", "OMICmAge_model3_z"),
    #                                        color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")
    # gg# save(paste0(savePath,"fused_model3_plot", suffix, ".png"), plot = fused_plot_model3)
  
  
  #Package raw results
  surv_results_model1_raw <- list(
      DunedinPACE_model1 = DunedinPACE_model1,
      GrimAge_PCAgeDev_model1 = GrimAge_PCAgeDev_model1,
      OMICmAgeAgeDev_model1 = OMICmAgeAgeDev_model1
  )
  surv_results_model2_raw <- list(
      DunedinPACE_model2 = DunedinPACE_model2,
      GrimAge_PCAgeDev_model2 = GrimAge_PCAgeDev_model2,
      OMICmAgeAgeDev_model2 = OMICmAgeAgeDev_model2
  )
  surv_results_model3_raw <- list(
      DunedinPACE_model3 = DunedinPACE_model3,
      GrimAge_PCAgeDev_model3 = GrimAge_PCAgeDev_model3,
      OMICmAgeAgeDev_model3 = OMICmAgeAgeDev_model3
  )
  surv_results_raw <- list(
      surv_results_model1_raw = surv_results_model1_raw,
      surv_results_model2_raw = surv_results_model2_raw,
      surv_results_model3_raw = surv_results_model3_raw
  )
  
  #Package SD results
  surv_results_model1_sd <- list(
      DunedinPACE_model1_z = DunedinPACE_model1_z,
      GrimAge_model1_z = GrimAge_model1_z,
      OMICmAge_model1_z = OMICmAge_model1_z
  )
  surv_results_model2_sd <- list(
      DunedinPACE_model2_z = DunedinPACE_model2_z,
      GrimAge_model2_z = GrimAge_model2_z,
      OMICmAge_model2_z = OMICmAge_model2_z
  )
  surv_results_model3_sd <- list(
      DunedinPACE_model3_z = DunedinPACE_model3_z,
      GrimAge_model3_z = GrimAge_model3_z,
      OMICmAge_model3_z = OMICmAge_model3_z
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