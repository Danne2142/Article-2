

#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey1")
# Rename dataframe in this new script
DunedinPACE_Model1_survey1<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe

#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey2")
# Rename dataframe in this new script
DunedinPACE_Model1_survey2<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe

#Load data
load("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/DunedinPACE_Model1_main_survey3")
# Rename dataframe in this new script
DunedinPACE_Model1_survey3<-DunedinPACE_Model1
rm(DunedinPACE_Model1) # Remove old dataframe


install.packages("meta")
install.packages("metafor")
library(meta)
library(metafor)


Results <- metagen(TE = studier$effect, seTE = studier$standardfel,
                     studlab = studier$studie, comb.fixed = TRUE, comb.random = TRUE,
                     method.tau = "DL")
