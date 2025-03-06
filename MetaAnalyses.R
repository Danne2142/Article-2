

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



library(meta)
library(metafor)

# Make sure you have your common exposures defined as before
common_exposures <- Reduce(intersect, list(unique(DunedinPACE_Model1_survey1$Exposure),
                                             unique(DunedinPACE_Model1_survey2$Exposure),
                                             unique(DunedinPACE_Model1_survey3$Exposure)))

# Create a list where each element represents one common exposure with rows from each survey
exposure_results <- lapply(common_exposures, function(exp) {
  # Subset for each survey based on the current exposure
  res1 <- subset(DunedinPACE_Model1_survey1, Exposure == exp)
  res2 <- subset(DunedinPACE_Model1_survey2, Exposure == exp)
  res3 <- subset(DunedinPACE_Model1_survey3, Exposure == exp)
  
  # Combine results from the three surveys
  combined <- rbind(res1, res2, res3)
  return(combined)
})

names(exposure_results) <- common_exposures

# To view the dataframe for a specific exposure (for example, the first one):
View(exposure_results[[2]])


ma_gen <- metagen(TE = exposure_results[[1]]$estimate, seTE = exposure_results[[1]]$std.error, sm = "MD",
                  common = FALSE, random = TRUE)

summary(ma_gen)

forest(ma_gen)
