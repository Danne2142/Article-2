

### Model 1 Supplement - Survey1

run_models <- function(
  interventions = c("Rapamycin_new", "Metformin_new", "fasting", "NAD", "TA65", 
  "sulforaphane", "DHEA_new", "SASP_supressors", "Resveratrol_new", "Exosomes", 
  "HRT", "spermidine"),
  lifestyle_covariates_survey1 = c("Alcohol_per_week_numeric",  
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

  # Import libraries

  p_load(ggplot2)


  # Run model1 to select significant variables
  combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), exposure_vars=c(interventions,lifestyle_covariates_survey1), covariate_vars = covariates_to_always_include)


  if (saveModel1==TRUE) {
    # Save DunedinPACE plot
    p1 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = " Aging Pace (biological year/chronological year)")
    ggsave(paste0(savePath,"DunedinPACE_Model1_Survey1_plot", suffix, ".png"), plot = p1)

    # Save GrimAge.PCAgeDev plot
    p2 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model1_Survey1_plot", suffix, ".png"), plot = p2)

    # Save OMICmAgeAgeDev plot
    p3 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"OMICmAgeAgeDev_Model1_Survey1_plot", suffix, ".png"), plot = p3)
  }
  # Save as dataframes
  DunedinPACE_Model1_Survey1<-combined_results_df[["DunedinPACE"]]
  GrimAge_PCAgeDev_Model2_Survey1<-combined_results_df[["GrimAge.PCAgeDev"]]
  OMICmAgeAgeDev_Model1_Survey1<-combined_results_df[["OMICmAgeAgeDev"]]


  lifestyle_covariates_survey1_updated <- remove_terms_if_p_large(
    lifestyle_covariates_survey1, categorical_variables_to_exclude=c("Main.Diet.Factor", "Exercise.Type"),
    list(DunedinPACE_Model1_Survey1, 
      GrimAge_PCAgeDev_Model2_Survey1, 
      OMICmAgeAgeDev_Model1_Survey1))


  interventions_large_p <- remove_terms_if_p_large(
    interventions, 
    list(DunedinPACE_Model1_Survey1, 
      GrimAge_PCAgeDev_Model2_Survey1, 
      OMICmAgeAgeDev_Model1_Survey1))



### Model 1 SD - Survey1


  if (saveModel1SD==TRUE) {
    combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), exposure_vars=c(interventions,lifestyle_covariates_survey1), covariate_vars = covariates_to_always_include)

    # Save as dataframes
    DunedinPACE<-combined_results_df[["DunedinPACE_z"]]
    GrimAge<-combined_results_df[["GrimAge.PCAgeDev_z"]]
    OmicAge<-combined_results_df[["OMICmAgeAgeDev_z"]]

    fused_plot_model1 <- forestplot_fusion(DunedinPACE,
                                    GrimAge,
                                    OmicAge,
                                    source_names = c("DunedinPACE", "GrimAge", "OmicAge"),
                                    color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")

    ggsave(paste0(savePath,"fused_Model1SD_Survey1_plot", suffix, ".png"), plot = fused_plot_model1)
 }


  ### Model 2 -survey 1
  covariates_to_always_include<-c(covariates_to_always_include, lifestyle_covariates_survey1_updated)

 if (saveModel2==TRUE) {# Save DunedinPACE plot
  combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), exposure_vars=interventions_large_p, covariate_vars = covariates_to_always_include)

  p4 <- plot_forest(combined_results_df[["DunedinPACE"]], ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
  ggsave(paste0(savePath,"DunedinPACE_Model2_Survey1_plot", suffix, ".png"), plot = p4)

  # Save GrimAge.PCAgeDev plot
  p5 <- plot_forest(combined_results_df[["GrimAge.PCAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model2_Survey1_plot", suffix, ".png"), plot = p5)

  # Save OMICmAgeAgeDev plot
  p6 <- plot_forest(combined_results_df[["OMICmAgeAgeDev"]], ylab ="Term", xlab = "Age Deviation (years)")
  ggsave(paste0(savePath,"OMICmAgeAgeDev_Model2_Survey1_plot", suffix, ".png"), plot = p6)
 

  # Save as dataframes
  DunedinPACE_Model2_Survey1<-combined_results_df[["DunedinPACE"]]
  GrimAge_PCAgeDev_Model2_Survey1<-combined_results_df[["GrimAge.PCAgeDev"]]
  OMICmAgeAgeDev_Model2_Survey1<-combined_results_df[["OMICmAgeAgeDev"]]
}

### Model 2 SD - Survey1
 if (saveModel2SD==TRUE) {# Save DunedinPACE plot
  combined_results_df<-model_exposure_wise(imputed_data=imp_data, outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), exposure_vars=interventions_large_p, covariate_vars = covariates_to_always_include)

  # Save as dataframes
  DunedinPACE<-combined_results_df[["DunedinPACE_z"]]
  GrimAge<-combined_results_df[["GrimAge.PCAgeDev_z"]]
  OmicAge<-combined_results_df[["OMICmAgeAgeDev_z"]]

  fused_plot_model2 <- forestplot_fusion(DunedinPACE,
                                  GrimAge,
                                  OmicAge,
                                  source_names = c("DunedinPACE", "GrimAge", "OmicAge"),
                                  color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")

  ggsave(paste0(savePath,"fused_Model2SD_Survey1_plot", suffix, ".png"), plot = fused_plot_model2)
}


### Model 3 - Survey 1
 if (saveModel3==TRUE) {# Save DunedinPACE plot
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    DunedinPACE <- subset(model3_DunedinPACE, term %in% interventions_large_p)
    # Save DunedinPACE plot
    p7 <- plot_forest(DunedinPACE, ylab ="Term", xlab = "Aging Pace (biological year/chronological year)")
    ggsave(paste0(savePath,"DunedinPACE_Model3_Survey1_plot", suffix, ".png"), plot = p7)

    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    GrimAge <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)
    # Save GrimAge.PCAgeDev plot
    p8 <- plot_forest(GrimAge, ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"GrimAge_PCAgeDev_Model3_Survey1_plot", suffix, ".png"), plot = p8)

    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    OmicAge <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)
    # Save OMICmAgeAgeDev plot
    p9 <- plot_forest(OmicAge, ylab ="Term", xlab = "Age Deviation (years)")
    ggsave(paste0(savePath,"OMICmAgeAgeDev_Model3_Survey1_plot", suffix, ".png"), plot = p9)
}



### Model 3 SD - Survey1
 if (saveModel3SD==TRUE) {# Save DunedinPACE plot
    model3_DunedinPACE <- fit_imputed_lm(imp_data, outcome = "DunedinPACE_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    DunedinPACE <- subset(model3_DunedinPACE, term %in% interventions_large_p)

    # Save as dataframes
    DunedinPACE_Model3_Survey1<-combined_results_df[["DunedinPACE_z"]]

    model3_GrimAge_PCAgeDev <- fit_imputed_lm(imp_data, outcome = "GrimAge.PCAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    GrimAge <- subset(model3_GrimAge_PCAgeDev, term %in% interventions_large_p)

    model3_OMICmAgeAgeDev <- fit_imputed_lm(imp_data, outcome = "OMICmAgeAgeDev_z", exposures = interventions_large_p, covariates = covariates_to_always_include)
    # Filter to only include exposures in the forest plot
    OmicAge <- subset(model3_OMICmAgeAgeDev, term %in% interventions_large_p)

    fused_plot_model3 <- forestplot_fusion(DunedinPACE,
                                    GrimAge,
                                    OmicAge,
                                    source_names = c("DunedinPACE", "GrimAge", "OmicAge"),
                                    color_values = c("darkred", "navy", "forestgreen"), ylab ="Term", xlab = "SD")

    ggsave(paste0(savePath,"fused_Model3_Survey1_plot", suffix, ".png"), plot = fused_plot_model3)
 }
}


# Generate sensitivity analysis for diabetics
# Load corresponding data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1_only_diabetes2")
#rename object
imputed_survey1_only_diabetes2 <- imputed_data
df1_imp_data_surv1_only_diabetes2<-complete(imputed_data, 1)
