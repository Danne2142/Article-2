library(writexl)

run_models_metformin <- function(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates =  c("Alcohol_per_week_numeric",  
"Education_levels_numeric", "Stress.Level", "Tobacco.Use.Numeric", 
"Exercise.per.week_numeric", "harmonized_diet", "organ_systems_afflicted_by_disease", "BMI",  "Marital.Status_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
suffix = "_main_survey1"
){


### Model 1 Supplement - Survey1
# Check that the column values are compatible with analysis
inspect_columns(complete(imp_data, 1), c(interventions, lifestyle_covariates, covariates_to_always_include))

# Run model1
print("Run model1")
combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                           outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
                                           exposure_vars=c(interventions, lifestyle_covariates), 
                                           covariate_vars=covariates_to_always_include)


# Save dataframes
DunedinPACE_Model1 <- combined_results_df[["DunedinPACE"]]
# write_xlsx(DunedinPACE_Model1,  paste0(savePath,"DunedinPACE_Model1", suffix))
GrimAge_PCAgeDev_Model1 <- combined_results_df[["GrimAge.PCAgeDev"]]
# write_xlsx(GrimAge_PCAgeDev_Model1,  paste0(savePath,"GrimAge_PCAgeDev_Model1", suffix))
OMICmAgeAgeDev_Model1 <- combined_results_df[["OMICmAgeAgeDev"]]
# write_xlsx(OMICmAgeAgeDev_Model1,  paste0(savePath,"OMICmAgeAgeDev_Model1", suffix))

lifestyle_covariates_updated <- lifestyle_covariates


### Model 1 SD 
  print("Run Model 1 SD ")
  combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                             outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
                                             exposure_vars=c(interventions, lifestyle_covariates), 
                                             covariate_vars=covariates_to_always_include)
  DunedinPACE_Model1_z <- combined_results_df[["DunedinPACE_z"]]
  # write_xlsx(DunedinPACE_Model1_z,  paste0(savePath,"DunedinPACE_Model1_z", suffix))
  GrimAge_Model1_z <- combined_results_df[["GrimAge.PCAgeDev_z"]]
  # write_xlsx(GrimAge_Model1_z,  paste0(savePath,"GrimAge_Model1_z", suffix))
  OMICmAge_Model1_z <- combined_results_df[["OMICmAgeAgeDev_z"]]
  # write_xlsx(OMICmAge_Model1_z,  paste0(savePath,"OMICmAge_Model1_z", suffix))


### Model 2 
covariates_to_always_include <- c(covariates_to_always_include, lifestyle_covariates_updated)
  print("Run Model 2")
  combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                             outcome_vars=c("DunedinPACE", "GrimAge.PCAgeDev", "OMICmAgeAgeDev"), 
                                             exposure_vars=interventions, 
                                             covariate_vars=covariates_to_always_include)
  DunedinPACE_Model2 <- combined_results_df[["DunedinPACE"]]
  # write_xlsx(DunedinPACE_Model2,  paste0(savePath,"DunedinPACE_Model2", suffix))
  GrimAge_PCAgeDev_Model2 <- combined_results_df[["GrimAge.PCAgeDev"]]
  # write_xlsx(GrimAge_PCAgeDev_Model2,  paste0(savePath,"GrimAge_PCAgeDev_Model2", suffix))
  OMICmAgeAgeDev_Model2 <- combined_results_df[["OMICmAgeAgeDev"]]
  # write_xlsx(OMICmAgeAgeDev_Model2,  paste0(savePath,"OMICmAgeAgeDev_Model2", suffix))


### Model 2 SD 
  print("Run Model 2 SD")
  combined_results_df <- model_exposure_wise(imputed_data=imp_data, 
                                             outcome_vars=c("DunedinPACE_z", "GrimAge.PCAgeDev_z", "OMICmAgeAgeDev_z"), 
                                             exposure_vars=interventions, 
                                             covariate_vars=covariates_to_always_include)
  DunedinPACE_Model2_z <- combined_results_df[["DunedinPACE_z"]]
  # write_xlsx(DunedinPACE_Model2_z,  paste0(savePath,"DunedinPACE_Model2_z", suffix))
  GrimAge_Model2_z <- combined_results_df[["GrimAge.PCAgeDev_z"]]
  # write_xlsx(GrimAge_Model2_z,  paste0(savePath,"GrimAge_Model2_z", suffix))
  OMICmAge_Model2_z <- combined_results_df[["OMICmAgeAgeDev_z"]]
  # write_xlsx(OMICmAge_Model2_z,  paste0(savePath,"OMICmAge_Model2_z", suffix))


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

 surv_results_raw <- list(
    surv_results_model1_raw = surv_results_model1_raw,
    surv_results_model2_raw = surv_results_model2_raw
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


surv_results_sd <- list(
    surv_results_model1_sd = surv_results_model1_sd,
    surv_results_model2_sd = surv_results_model2_sd
)

#Package all results which the function will return
surv_results <- list(
    surv_results_raw = surv_results_raw,
    surv_results_sd = surv_results_sd
)

return(surv_results)
}