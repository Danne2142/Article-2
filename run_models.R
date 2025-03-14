

### Model 1 Supplement - Survey1

run_models <- function(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates = c("Alcohol_per_week_numeric",  
  "Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
  "Exercise.per.week_numeric", "Exercise.Type",
  "Main.Diet.Factor" , "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
  covariates_to_always_include=c("Decimal.Chronological.Age", "Biological.Sex" ),
  imp_data = imp_data_surv1,
  saveModel1=FALSE,
  saveModel1SD=FALSE,
  saveModel2=FALSE,
  saveModel2SD=FALSE,
  saveModel3=FALSE,
  saveModel3SD=FALSE,
  savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
  suffix = "_main") { 

  # Check that the column values compatible with analysis
  inspect_columns(complete(imp_data, 1), c(interventions, lifestyle_covariates, covariates_to_always_include))


  # Import libraries

  p_load(ggplot2)


  # Run model1 to select significant variables
  print("Run model1 to select significant variables")

  #Run model 1
  combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), exposure_vars=c(interventions,lifestyle_covariates), covariate_vars = covariates_to_always_include)


  if (saveModel1==TRUE) {
    # Save DunedinPACE plot
    p1 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = " Aging Pace (biological year/chronological year)")
    ggsave(paste0(savePath,"DunedinPACE_Model1_plot", suffix, ".png"), plot = p1)

    # Save GrimAge.PCAgeDev plot
    p2 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model1_plot", suffix, ".png"), plot = p2)

    # Save OMICmAgeAgeDev plot
    p3 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"OMICmAgeAgeDev_Model1_plot", suffix, ".png"), plot = p3)
  }
  # Save as dataframes
  DunedinPACE_Model1<-combined_results_df[["DunedinPACE"]]
  save(DunedinPACE_Model1, file = paste0(savePath,"DunedinPACE_Model1", suffix))
  GrimAge_PCAgeDev_Model1<-combined_results_df[["GrimAge.PCAgeDev"]]
  save(GrimAge_PCAgeDev_Model1, file = paste0(savePath,"GrimAge_PCAgeDev_Model1", suffix))
  OMICmAgeAgeDev_Model1<-combined_results_df[["OMICmAgeAgeDev"]]
  save(OMICmAgeAgeDev_Model1, file = paste0(savePath,"OMICmAgeAgeDev_Model1", suffix))


  lifestyle_covariates_updated <- remove_terms_if_p_large(
    lifestyle_covariates, categorical_variables_to_exclude=c("Main.Diet.Factor", "Exercise.Type"),
    list(DunedinPACE_Model1, 
      GrimAge_PCAgeDev_Model1, 
      OMICmAgeAgeDev_Model1))


  interventions_large_p <- remove_terms_if_p_large(
    interventions, 
    list(DunedinPACE_Model1, 
      GrimAge_PCAgeDev_Model1, 
      OMICmAgeAgeDev_Model1))



### Model 1 SD 


  if (saveModel1SD==TRUE) {
    print("Run Model 1 SD ")
    combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), exposure_vars=c(interventions,lifestyle_covariates), covariate_vars = covariates_to_always_include)

    # Save as dataframes
    DunedinPACE_Model1_z<-combined_results_df[["DunedinPACE_z"]]
    save(DunedinPACE_Model1_z, file = paste0(savePath,"DunedinPACE_Model1_z", suffix))

    GrimAge_Model1_z<-combined_results_df[["GrimAge.PCAgeDev_z"]]
    save(GrimAge_Model1_z, file = paste0(savePath,"GrimAge_Model1_z", suffix))

    OmicAge_Model1_z<-combined_results_df[["OMICmAgeAgeDev_z"]]
    save(OmicAge_Model1_z, file = paste0(savePath,"OmicAge_Model1_z", suffix))


    fused_plot_model1 <- forestplot_fusion(DunedinPACE_Model1_z,
                                    GrimAge_Model1_z,
                                    OmicAge_Model1_z,
                                    source_names = c("DunedinPACE_Model1_z", "GrimAge_Model1_z", "OmicAge_Model1_z"),
                                    color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")

    ggsave(paste0(savePath,"fused_Model1SD_plot", suffix, ".png"), plot = fused_plot_model1)
 }


  ### Model 2 


  covariates_to_always_include<-c(covariates_to_always_include, lifestyle_covariates_updated)

 if (saveModel2==TRUE) {# Save DunedinPACE plot
  print("Run Model 2")

  combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), exposure_vars=interventions_large_p, covariate_vars = covariates_to_always_include)

  p4 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
  ggsave(paste0(savePath,"DunedinPACE_Model2_plot", suffix, ".png"), plot = p4)

  # Save GrimAge.PCAgeDev plot
  p5 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model2_plot", suffix, ".png"), plot = p5)

  # Save OMICmAgeAgeDev plot
  p6 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0(savePath,"OMICmAgeAgeDev_Model2_plot", suffix, ".png"), plot = p6)
 

  # Save as dataframes
  DunedinPACE_Model2<-combined_results_df[["DunedinPACE"]]
  save(DunedinPACE_Model2, file = paste0(savePath,"DunedinPACE_Model2", suffix))

  GrimAge_PCAgeDev_Model2<-combined_results_df[["GrimAge.PCAgeDev"]]
  save(GrimAge_PCAgeDev_Model2, file = paste0(savePath,"GrimAge_PCAgeDev_Model2", suffix))

  OMICmAgeAgeDev_Model2<-combined_results_df[["OMICmAgeAgeDev"]]
  save(OMICmAgeAgeDev_Model2, file = paste0(savePath,"OMICmAgeAgeDev_Model2", suffix))

}

### Model 2 SD 


 if (saveModel2SD==TRUE) {# Save DunedinPACE plot
  print("Run Model 2 SD")

  combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), exposure_vars=interventions_large_p, covariate_vars = covariates_to_always_include)

  # Save as dataframes
  DunedinPACE_Model2_z<-combined_results_df[["DunedinPACE_z"]]
  save(DunedinPACE_Model2_z, file = paste0(savePath,"DunedinPACE_Model2_z", suffix))

  GrimAge_Model2_z<-combined_results_df[["GrimAge.PCAgeDev_z"]]
  save(GrimAge_Model2_z, file = paste0(savePath,"GrimAge_Model2_z", suffix))

  OmicAge_Model2_z<-combined_results_df[["OMICmAgeAgeDev_z"]]
  save(OmicAge_Model2_z, file = paste0(savePath,"OmicAge_Model2_z", suffix))


  fused_plot_model2 <- forestplot_fusion(DunedinPACE_Model2_z,
                                  GrimAge_Model2_z,
                                  OmicAge_Model2_z,
                                  source_names = c("DunedinPACE_Model2_z", "GrimAge_Model2_z", "OmicAge_Model2_z"),
                                  color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")

  ggsave(paste0(savePath,"fused_Model2SD_plot", suffix, ".png"), plot = fused_plot_model2)
}


### Model 3

 if (saveModel3==TRUE) {# Save DunedinPACE plot
 print("Run Model 3")

    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    DunedinPACE_Model3 <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    save(DunedinPACE_Model3, file = paste0(savePath,"DunedinPACE_Model3", suffix))
    # Save DunedinPACE plot
    p7 <- plot_forest(DunedinPACE_Model3, ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
    ggsave(paste0(savePath,"DunedinPACE_Model3_plot", suffix, ".png"), plot = p7)

    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    GrimAge_Model3 <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    save(GrimAge_Model3, file = paste0(savePath,"GrimAge_PCAgeDev_Model3", suffix))
    # Save GrimAge.PCAgeDev plot
    p8 <- plot_forest(GrimAge_Model3, ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model3_plot", suffix, ".png"), plot = p8)

    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    OmicAge_Model3 <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    save(OmicAge_Model3, file = paste0(savePath,"OmicAgeAgeDev_Model3", suffix))
    # Save OMICmAgeAgeDev plot
    p9 <- plot_forest(OmicAge_Model3, ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"OMICmAgeAgeDev_Model3_plot", suffix, ".png"), plot = p9)
}



### Model 3 SD

 if (saveModel3SD==TRUE) {# Save DunedinPACE plot
    print("Run Model 3 SD")
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    DunedinPACE_Model3_z <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    save(DunedinPACE_Model3_z, file = paste0(savePath,"DunedinPACE_Model3_z", suffix))


    # Save as dataframes
    DunedinPACE_Model3<-combined_results_df[["DunedinPACE_z"]] 

    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    GrimAge_Model3_z <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    save(GrimAge_Model3_z, file = paste0(savePath,"GrimAge_Model3_z", suffix))


    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    OmicAge_Model3_z <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    save(OmicAge_Model3_z, file = paste0(savePath,"OmicAge_Model3_z", suffix))


    fused_plot_model3 <- forestplot_fusion(DunedinPACE_Model3_z,
                                    GrimAge_Model3_z,
                                    OmicAge_Model3_z,
                                    source_names = c("DunedinPACE_Model3_z", "GrimAge_Model3_z", "OmicAge_Model3_z"),
                                    color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")

    ggsave(paste0(savePath,"fused_Model3_plot", suffix, ".png"), plot = fused_plot_model3)
 }
}
