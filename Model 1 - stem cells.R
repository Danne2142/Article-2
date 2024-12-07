


data <- read.csv("C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/filtered_df_crossectional_harmonized", header=TRUE, stringsAsFactors=FALSE)

# Behåll endast rader där 'Biological.Sex' är antingen 'Female' eller 'Male'
data <- subset(data, Biological.Sex %in% c("Female", "Male"))

data$AgeDevGrim <- data$GrimAge.PC - data$Decimal.Chronological.Age
data$AgeDevOMIC <- data$OMICmAge - data$Decimal.Chronological.Age
# data$AgeDevDunedin <- data$hp - data$wt

# Skapa den linjära regressionsmodellen
modelGrim <- lm( AgeDevGrim~ Stem_cells + Biological.Sex + Decimal.Chronological.Age, data = data)
summary(modelGrim)
confint(modelGrim)

modelOMIC <- lm( AgeDevOMIC~ Stem_cells + Biological.Sex + Decimal.Chronological.Age, data = data)
summary(modelOMIC)
confint(modelOMIC)

modelDunedin <- lm(DunedinPoAm~ Stem_cells + Biological.Sex + Decimal.Chronological.Age, data = data)

# Visa sammanfattning av modellen
summary(modelDunedin)
confint(modelDunedin)



# Installera och ladda nödvändiga paket
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(dplyr)) install.packages("dplyr")
if (!require(broom)) install.packages("broom")
library(ggplot2)
library(dplyr)
library(broom)

# Extrahera konfidensintervall och punktuppskattningar för "Stem_cells"
ci_grim <- confint(modelGrim)["Stem_cellsTRUE", ]
coef_grim <- coef(summary(modelGrim))["Stem_cellsTRUE", "Estimate"]

ci_omic <- confint(modelOMIC)["Stem_cellsTRUE", ]
coef_omic <- coef(summary(modelOMIC))["Stem_cellsTRUE", "Estimate"]

ci_dunedin <- confint(modelDunedin)["Stem_cellsTRUE", ]
coef_dunedin <- coef(summary(modelDunedin))["Stem_cellsTRUE", "Estimate"]

# Kombinera resultaten i en dataframe
results <- data.frame(
  Model = c("GrimAge", "OMICmAge", "DunedinPoAm"),
  Estimate = c(coef_grim, coef_omic, coef_dunedin),
  CI_Lower = c(ci_grim[1], ci_omic[1], ci_dunedin[1]),
  CI_Upper = c(ci_grim[2], ci_omic[2], ci_dunedin[2])
)


# Skapa en skogskarta med en vertikal linje vid 0
ggplot(results, aes(x = Estimate, y = Model)) +
  geom_point() +
  geom_errorbarh(aes(xmin = CI_Lower, xmax = CI_Upper), height = 0.2) +
  geom_vline(xintercept = 0, linetype = "dSashed", color = "red") + # Vertikal linje vid 0
  xlab("Estimate and 95% CI for 'Stem_cells'") +
  ylab("Model") +
  theme_minimal()

# Visa alla koefficienter i modelGrim
summary(modelGrim)$coefficients

# Alternativt
coefficients(modelGrim)

# 
# 
# #Assume 'df' is your dataframe
# column_names <- names(data)
# 
# #Print the column names
# print(column_names)