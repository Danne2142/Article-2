library(meta)
# p_load(metafor)



# Meta analysis for Model 1

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey1")
# Rename dataframe in this new script
DunedinPACE_Model1_survey1<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey2")
# Rename dataframe in this new script
DunedinPACE_Model1_survey2<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey3")
# Rename dataframe in this new script
DunedinPACE_Model1_survey3<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe


# Make sure you have your common terms defined as before
common_terms <- Reduce(intersect, list(unique(DunedinPACE_Model1_survey1$term),
                                             unique(DunedinPACE_Model1_survey2$term),
                                             unique(DunedinPACE_Model1_survey3$term)))

# Create a list where each element represents one common term with rows from each survey
term_results <- lapply(common_terms, function(exp) {
  # Subset for each survey based on the current term
  res1 <- subset(DunedinPACE_Model1_survey1, term == exp)
  res2 <- subset(DunedinPACE_Model1_survey2, term == exp)
  res3 <- subset(DunedinPACE_Model1_survey3, term == exp)
  
  # Combine results from the three surveys
  combined <- rbind(res1, res2, res3)
  return(combined)
})

names(term_results) <- common_terms

# # To view the dataframe for a specific term (for example, the first one):
# View(term_results[[2]])


# Loop through each term and create a forest plot
for (i in seq_along(term_results)) {
  # Generate meta-analysis for the current term
  ma_gen <- meta::metagen(TE = term_results[[i]]$estimate, seTE = term_results[[i]]$std.error, sm = "MD",
                    common = FALSE, random = TRUE)
  
  # Extract Outcome value (assumed same for every row)
  outcome <- term_results[[i]]$Outcome[1]
  
  # Start png device with Outcome in file name
  png(paste0("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/forest_plot_model1_", names(term_results)[i], "_", outcome, ".png"), width = 800, height = 600)
  
  # Create the plot
  meta::forest(ma_gen)
  
  # Close the graphics device
  dev.off()
}


# Meta analysis for Model 2

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_main_survey1")
# Rename dataframe in this new script
DunedinPACE_Model2_survey1<-DunedinPACE_Model2
rm(DunedinPACE_Model2) # Remove old dataframe

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_main_survey2")
# Rename dataframe in this new script
DunedinPACE_Model2_survey2<-DunedinPACE_Model2
rm(DunedinPACE_Model2) # Remove old dataframe

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model2_main_survey3")
# Rename dataframe in this new script
DunedinPACE_Model2_survey3<-DunedinPACE_Model2
rm(DunedinPACE_Model2) # Remove old dataframe


# Make sure you have your common terms defined as before
common_terms <- Reduce(intersect, list(unique(DunedinPACE_Model2_survey1$term),
                                             unique(DunedinPACE_Model2_survey2$term),
                                             unique(DunedinPACE_Model2_survey3$term)))

# Create a list where each element represents one common term with rows from each survey
term_results <- lapply(common_terms, function(exp) {
  # Subset for each survey based on the current term
  res1 <- subset(DunedinPACE_Model2_survey1, term == exp)
  res2 <- subset(DunedinPACE_Model2_survey2, term == exp)
  res3 <- subset(DunedinPACE_Model2_survey3, term == exp)
  
  # Combine results from the three surveys
  combined <- rbind(res1, res2, res3)
  return(combined)
})

names(term_results) <- common_terms

# # To view the dataframe for a specific term (for example, the first one):
# View(term_results[[2]])


# Loop through each term and create a forest plot
for (i in seq_along(term_results)) {
  # Generate meta-analysis for the current term
  ma_gen <- meta::metagen(TE = term_results[[i]]$estimate, seTE = term_results[[i]]$std.error, sm = "MD",
                    common = FALSE, random = TRUE)
  
  # Extract Outcome value (assumed same for every row)
  outcome <- term_results[[i]]$Outcome[1]
  
  # Start png device with Outcome in file name
  png(paste0("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/forest_plot_model2_", names(term_results)[i], "_", outcome, ".png"), width = 800, height = 600)
  
  # Create the plot
  meta::forest(ma_gen)
  
  # Close the graphics device
  dev.off()
}


# Meta analysis for Model 3

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_main_survey1")
# Rename dataframe in this new script
DunedinPACE_Model3_survey1<-DunedinPACE_Model3
rm(DunedinPACE_Model3) # Remove old dataframe

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_main_survey2")
# Rename dataframe in this new script
DunedinPACE_Model3_survey2<-DunedinPACE_Model3
rm(DunedinPACE_Model3) # Remove old dataframe

#Load data
load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model3_main_survey3")
# Rename dataframe in this new script
DunedinPACE_Model3_survey3<-DunedinPACE_Model3
rm(DunedinPACE_Model3) # Remove old dataframe


# Make sure you have your common terms defined as before
common_terms <- Reduce(intersect, list(unique(DunedinPACE_Model3_survey1$term),
                                             unique(DunedinPACE_Model3_survey2$term),
                                             unique(DunedinPACE_Model3_survey3$term)))

# Create a list where each element represents one common term with rows from each survey
term_results <- lapply(common_terms, function(exp) {
  # Subset for each survey based on the current term
  res1 <- subset(DunedinPACE_Model3_survey1, term == exp)
  res2 <- subset(DunedinPACE_Model3_survey2, term == exp)
  res3 <- subset(DunedinPACE_Model3_survey3, term == exp)
  
  # Combine results from the three surveys
  combined <- rbind(res1, res2, res3)
  return(combined)
})

names(term_results) <- common_terms

# # To view the dataframe for a specific term (for example, the first one):
# View(term_results[[2]])


# Loop through each term and create a forest plot
for (i in seq_along(term_results)) {
  # Generate meta-analysis for the current term
  ma_gen <- meta::metagen(TE = term_results[[i]]$estimate, seTE = term_results[[i]]$std.error, sm = "MD",
                    common = FALSE, random = TRUE)
  
  # Extract Outcome value (assumed same for every row)
  outcome <- term_results[[i]]$Outcome[2]
  
  # Start png device with Outcome in file name
  png(paste0("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/forest_plot_Model3_", names(term_results)[i], "_", outcome, ".png"), width = 800, height = 600)
  
  # Create the plot
  meta::forest(ma_gen)
  
  # Close the graphics device
  dev.off()
}