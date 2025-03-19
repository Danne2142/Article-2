library(pacman)
p_load(ggplot2, mice)
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/modelingFunctions.R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/plot_forest().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/forest_plot_fusion().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/run_models_metformin().R")



# Load required data and set objects
print("Generate main models")
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/imputed_survey1")
imp_data <- imputed_data
df1_imp_data <- complete(imputed_data, 1) # only for visualizing imputed data
# ...existing code to calculate missing summaries if needed...


run_models_metformin(
imp_data = imputed_data,
# Define parameters 
interventions = c("Metformin_new"),
lifestyle_covariates = c("Alcohol_per_week_numeric", "Education_levels_numeric", "Stress.Level", 
                          "Tobacco.Use.Numeric", "Exercise.per.week_numeric", "Exercise.Type",
                          "Main.Diet.Factor", "BMI", "Caffeine.Use_numeric", "Marital.Status_numeric", 
                          "Sexual.Frequency_numeric", "Hours.of.sleep.per.night_numeric"),
covariates_to_always_include = c("Decimal.Chronological.Age", "Biological.Sex"),
savePath = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/",
suffix = "_main_survey1"
)
