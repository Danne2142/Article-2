## -----------------------------------------------------------------------------
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/remove_other().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/logical_to_integer().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_to_factors().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_yes_no_to_logical().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/convert_to_logical().R")
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/char_cols_to_factors().R")


data <- read.csv("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step1", header=TRUE, stringsAsFactors=FALSE)



## -----------------------------------------------------------------------------
data<- remove_other(data, "Biological.Sex")



## -----------------------------------------------------------------------------
# Konvertera till Date-format
data$Collection.Date <- as.Date(data$Collection.Date, format = "%m/%d/%Y")



## -----------------------------------------------------------------------------

data_fixed_datatypes<-convert_to_logical(data, column_name="Diagnosed.with.low.or.high.calcium", false_values="No")

data_fixed_datatypes<-convert_to_logical(data_fixed_datatypes, column_name="Are.you.adopted.", false_values="No")

data_fixed_datatypes<-convert_to_logical(data_fixed_datatypes, column_name="Do.you.have.any.parents.or.grandparents.or.great.grandparents.that.live.to.or.beyond.100.years.old.", false_values="No")

data_fixed_datatypes<-convert_to_logical(data_fixed_datatypes, column_name="Track.Sleep.Wearable.Device", false_values="No")


data_fixed_datatypes<-convert_to_logical(data_fixed_datatypes, column_name="Lab.Fasting", false_values="No")


# Converting 'Strictly.Followed.Main.Diet' to an ordered factor
data_fixed_datatypes$Strictly.Followed.Main.Diet <- ordered(
  data_fixed_datatypes$Strictly.Followed.Main.Diet,
  levels = c(
    "Very strict. I consumed products that didn’t traditionally fall within the diet less than 2 days a week",
    "Moderately strict. I consumed products that didn’t traditionally fall within the diet 2-5 days a week",
    "Not very strict. I consumed products that didn’t traditionally fall within the diet 5-6 days a week"
  ),
  exclude = NA
)

# Converting 'Red.Meat.times.per.week' to an ordered factor
data_fixed_datatypes$Red.Meat.times.per.week <- ordered(
  data_fixed_datatypes$Red.Meat.times.per.week,
  levels = c("0-1 days", "1-3 days", "3-5 days", "6-7 days"),
  exclude = NA
)

# Converting 'Processed.Food.times.per.week' to an ordered factor
data_fixed_datatypes$Processed.Food.times.per.week <- ordered(
  data_fixed_datatypes$Processed.Food.times.per.week,
  levels = c("0-1 days", "1-3 days", "3-5 days", "6-7 days"),
  exclude = NA
)

# Converting 'Feel.Well.Rested.days.per.week' to an ordered factor
data_fixed_datatypes$Feel.Well.Rested.days.per.week <- ordered(
  data_fixed_datatypes$Feel.Well.Rested.days.per.week,
  levels = c("0-1 days", "1-3 days", "3-5 days", "6-7 days"),
  exclude = NA
)

# Converting 'Screens.before.bed' to an ordered factor
data_fixed_datatypes$Screens.before.bed <- ordered(
  data_fixed_datatypes$Screens.before.bed,
  levels = c("Once a month or less", "Once a week", "Multiple times a week", "Daily/near daily"),
  exclude = NA
)

# Converting 'Track.Sleep.Wearable.Device' to an ordered factor
# Assuming the two unique values are "No" and "Yes"
data_fixed_datatypes$Track.Sleep.Wearable.Device <- ordered(
  data_fixed_datatypes$Track.Sleep.Wearable.Device,
  levels = c("No", "Yes"),
  exclude = NA
)


data_fixed_datatypes$Recreational.Drug.Frequency <- ordered(data$Recreational.Drug.Frequency, 
                                   levels = c("Never", "On special occasions","Once per week", "Regularly", "3-5 times per week"), exclude=NA)


data_fixed_datatypes$Sexual.Frequency <- ordered(data$Sexual.Frequency, 
                                   levels = c("Inactive", "Occasionally", "Regularly"), exclude=NA)

data_fixed_datatypes$Hours.of.sleep.per.night <- ordered(data$Hours.of.sleep.per.night, 
                                   levels = c("6 hours or less", "6 to 8 hours", "More than 8 hours"), exclude=NA)

data_fixed_datatypes$Caffeine.Use <- ordered(data$Caffeine.Use, 
                                   levels = c("Never", "On special occasions", "Once per week", "3-5 times per week	", "Regularly"), exclude=NA)

data_fixed_datatypes$Exercise.per.week <- ordered(data$Exercise.per.week, 
                                   levels = c("Never", "1-2 times per week", "3-4 times per week", "5-7 times per week", "8 or more times per week"), exclude=NA)
# 
# # Convert to Ordered Factor
# data_fixed_datatypes$Education.of.Mother <- ordered(data$Education.of.Mother, 
#                                    levels = c("Did not complete high school", "High school or equivalent", "Technical or occupational certificate", "Some college coursework completed", "Associate degree", "Bachelor’s degree", "Master’s degree", "Professional (MD, DO, DDS, JD)", "Doctorate (PhD)"), exclude=NA)
# data_fixed_datatypes$Education.of.Father <- ordered(data$Education.of.Father, 
#                                    levels = c("Did not complete high school", "High school or equivalent", "Technical or occupational certificate", "Some college coursework completed", "Associate degree", "Bachelor’s degree", "Master’s degree", "Professional (MD, DO, DDS, JD)", "Doctorate (PhD)"), exclude=NA)
# data_fixed_datatypes$Level.of.Education <- ordered(data$Level.of.Education, 
#                                    levels = c("Did not complete high school", "High school or equivalent", "Technical or occupational certificate", "Some college coursework completed", "Associate degree", "Bachelor’s degree", "Master’s degree", "Professional (MD, DO, DDS, JD)", "Doctorate (PhD)"), exclude=NA)

# Convert to Ordered Factor
data_fixed_datatypes$Tobacco.Use <- ordered(data$Tobacco.Use, 
                                   levels = c("None", "Less than 1 cigarette per week", "Less than 1 cigarette per day", "1-5 cigarettes per day", "6-10 cigarettes per day", "11-20 cigarettes per day", "More than 20 cigarettes per day"), exclude=NA)


# str(data_fixed_datatypes)

print(class(data_fixed_datatypes$Tobacco.Use))




## -----------------------------------------------------------------------------
data_fixed_datatypes <- logical_to_integer(data_fixed_datatypes)




## -----------------------------------------------------------------------------

data_fixed_datatypes <- char_cols_to_factors(data_fixed_datatypes,uniq_val_thresh=9, cols_to_skip = c("Patient.ID", "PID", "Collection.Date", "Array", "survey_version"))



## -----------------------------------------------------------------------------
# write.csv(data_fixed_datatypes, file = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step2", row.names = FALSE)
save(data_fixed_datatypes, file ="C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/data_after_step2")


