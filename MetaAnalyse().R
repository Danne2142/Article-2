MetaAnalyse <- function(survey1 = NULL, survey2 = NULL, survey3 = NULL, savePath = NULL, model_no = NULL) {

library(meta)

# p_load(metafor)

# Meta analysis for Model 1


# Make sure you have your common terms defined as before
common_terms <- Reduce(intersect, list(unique(survey1$term),
                                             unique(survey2$term),
                                             unique(survey3$term)))

# Create a list where each element represents one common term with rows from each survey
term_results <- lapply(common_terms, function(exp) {
  # Subset for each survey based on the current term
  res1 <- subset(survey1, term == exp)
  res2 <- subset(survey2, term == exp)
  res3 <- subset(survey3, term == exp)
  
  # Combine results from the three surveys
  combined <- rbind(res1, res2, res3)
  return(combined)
})
names(term_results) <- common_terms

# # To view the dataframe for a specific term (for example, the first one):
# View(term_results[[2]])

model_results <- data.frame()  # initialize empty dataframe for Model 1

# Loop through each term and create a forest plot
for (i in seq_along(term_results)) {
  # Generate meta-analysis for the current term
    # Calculate both models
    ma_random <- meta::metagen(TE = term_results[[i]]$estimate, seTE = term_results[[i]]$std.error, sm = "MD",
                               random = TRUE, common = FALSE)        
    ma_fixed  <- meta::metagen(TE = term_results[[i]]$estimate, seTE = term_results[[i]]$std.error, sm = "MD",  
                               random = FALSE, common = TRUE)
                               
    # Choose model based on heterogeneity condition  print(paste0("Term: ", names(term_results)[i]))
    if (ma_random$I2 > 0.50 && ma_random$pval.Q < 0.05) {
         ma_gen <- ma_random
    } else { 
         ma_gen <-ma_fixed
    }

    # All rows have the same value in otcome, so we can just take the first one
    outcome <- term_results[[i]]$Outcome[1]
    # print(paste0("Outcome: ", outcome))
    # print(paste0("Term: ", names(term_results)[i]))


    #Create  dataframe
    result_row <- data.frame(
      Outcome      = outcome,
      Term         = names(term_results)[i],
      I2           = ma_gen$I2,
      pval_Q       = ma_gen$pval.Q,
      TE_random    = ma_gen$TE.random,
      lower_random = ma_gen$lower.random,
      upper_random = ma_gen$upper.random,
      pval_random  = ma_gen$pval.random,
      TE_common    = ma_gen$TE.common,
      lower_common = ma_gen$lower.common,
      upper_common = ma_gen$upper.common,
      pval_common  = ma_gen$pval.common,
      stringsAsFactors = FALSE
    )
    model_results <- rbind(model_results, result_row)

    # print(summary(ma_gen))

    # Start png device with Outcome in file name
    png(paste0(savePath, "forest_plot_model", model_no, "_", names(term_results)[i], "_", outcome, ".png"), width = 800, height = 600)
    
    # Create the plot
    meta::forest(ma_gen)
    
    # Close the graphics device
    dev.off()
}
rm(term_results) # Remove old term_results

#Save df
save(model_results, file = paste0(savePath, "model", model_no, "_meta_results.RData"))

return(model_results)
}


# #Load data
# load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey1")
# # Rename dataframe in this new script
# imp_survey1<-DunedinPACE_Model1
# rm(DunedinPACE_Model1) # Remove old dataframe

# #Load data
# load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey2")
# # Rename dataframe in this new script
# imp_survey2<-DunedinPACE_Model1
# rm(DunedinPACE_Model1) # Remove old dataframe

# #Load data
# load("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey3")
# # Rename dataframe in this new script
# imp_survey3<-DunedinPACE_Model1
# rm(DunedinPACE_Model1) # Remove old dataframe

# MetaAnalyse(survey1 = imp_survey1, survey2 = imp_survey2, survey3 = imp_survey3, savePath = "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/", model_no = 1)

