# Supplement and Drug Usage Histogram by Survey Version
# This script creates histograms showing the number of users for each supplement/drug
# across different survey versions based on data from Harmonizer Step 1

## Load required packages
library(pacman)
p_load(dplyr, ggplot2, tidyr, gridExtra)

## Set working directory and load data
# Load the harmonized data (assuming it's been processed by Harmonizer Step 1)
# Adjust the path to match your data location
data_path <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/"

# Try to load the processed data from Harmonizer Step 1
# You may need to adjust this path based on where the harmonized data is saved
df_harmonized <- read.csv(paste0(data_path, "data_after_step1"), 
                         header = TRUE, stringsAsFactors = FALSE)

# If the harmonized data is not available, we'll need to run the harmonizer first
# For now, let's assume we have access to the processed data

## Define supplements and drugs from Harmonizer Step 1
supplements_drugs <- c("NAD", "TA65", "sulforaphane", "DHEA_new", "Rapamycin_new", 
                      "SASP_supressors", "Metformin_new", "Resveratrol_new", 
                      "Exosomes", "stem_cells", "HRT", "spermidine", 
                      "semaglutide", "vitaminD", "AKG")

## Data processing for histogram
# Check if the required columns exist
if(!"survey_version" %in% colnames(df_harmonized)) {
  stop("Column 'survey_version' not found in the data")
}

# Check which supplement/drug columns are actually present in the data
available_supplements <- supplements_drugs[supplements_drugs %in% colnames(df_harmonized)]
missing_supplements <- supplements_drugs[!supplements_drugs %in% colnames(df_harmonized)]

if(length(missing_supplements) > 0) {
  cat("Warning: The following supplement/drug columns are missing from the data:\n")
  cat(paste(missing_supplements, collapse = ", "), "\n")
}

if(length(available_supplements) == 0) {
  stop("None of the specified supplement/drug columns were found in the data")
}

cat("Processing", length(available_supplements), "supplement/drug columns:\n")
cat(paste(available_supplements, collapse = ", "), "\n")

## Create summary data for plotting
# Convert supplement columns to logical if they're not already
df_plot <- df_harmonized %>%
  select(survey_version, all_of(available_supplements)) %>%
  # Convert survey_version to factor for better plotting
  mutate(survey_version = factor(survey_version, levels = c(1, 2, 3)))

# Convert supplement columns to logical (assuming 1/TRUE = using, 0/FALSE = not using)
for(col in available_supplements) {
  df_plot[[col]] <- as.logical(as.numeric(df_plot[[col]]))
}

# Reshape data for plotting
df_long <- df_plot %>%
  pivot_longer(cols = all_of(available_supplements), 
               names_to = "supplement", 
               values_to = "usage") %>%
  filter(!is.na(usage)) %>%  # Remove NA values
  group_by(survey_version, supplement) %>%
  summarise(
    total_users = n(),
    users_taking = sum(usage, na.rm = TRUE),
    percentage = round((users_taking / total_users) * 100, 1),
    .groups = "drop"
  )

## Create histogram plots

# Plot 1: Number of users taking each supplement by survey version
plot_users <- ggplot(df_long, aes(x = supplement, y = users_taking, fill = survey_version)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  labs(
    title = "Number of Users Taking Each Supplement/Drug by Survey Version",
    x = "Supplement/Drug",
    y = "Number of Users",
    fill = "Survey Version"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "top"
  ) +
  scale_fill_brewer(type = "qual", palette = "Set2")

# Plot 2: Percentage of users taking each supplement by survey version
plot_percentage <- ggplot(df_long, aes(x = supplement, y = percentage, fill = survey_version)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  labs(
    title = "Percentage of Users Taking Each Supplement/Drug by Survey Version",
    x = "Supplement/Drug",
    y = "Percentage of Users (%)",
    fill = "Survey Version"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "top"
  ) +
  scale_fill_brewer(type = "qual", palette = "Set2") +
  ylim(0, 100)

# Plot 3: Total sample size by survey version
sample_sizes <- df_plot %>%
  group_by(survey_version) %>%
  summarise(sample_size = n(), .groups = "drop")

plot_sample_size <- ggplot(sample_sizes, aes(x = survey_version, y = sample_size, fill = survey_version)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  geom_text(aes(label = sample_size), vjust = -0.5, size = 4) +
  labs(
    title = "Sample Size by Survey Version",
    x = "Survey Version",
    y = "Number of Participants"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "none"
  ) +
  scale_fill_brewer(type = "qual", palette = "Set2")

## Display plots
print(plot_users)
print(plot_percentage)
print(plot_sample_size)

## Save plots
ggsave(paste0(data_path, "supplement_usage_by_survey_absolute.png"), 
       plot_users, width = 12, height = 8, dpi = 300)
ggsave(paste0(data_path, "supplement_usage_by_survey_percentage.png"), 
       plot_percentage, width = 12, height = 8, dpi = 300)
ggsave(paste0(data_path, "sample_size_by_survey.png"), 
       plot_sample_size, width = 8, height = 6, dpi = 300)

## Print summary statistics
cat("\n=== SUMMARY STATISTICS ===\n")
cat("Sample sizes by survey version:\n")
print(sample_sizes)

cat("\nTop 5 most used supplements/drugs overall:\n")
top_supplements <- df_long %>%
  group_by(supplement) %>%
  summarise(total_users = sum(users_taking), .groups = "drop") %>%
  arrange(desc(total_users)) %>%
  head(5)
print(top_supplements)

cat("\nDetailed usage by survey version:\n")
print(df_long %>% arrange(supplement, survey_version))

cat("\nPlots saved to:", data_path, "\n")
cat("Script completed successfully!\n")
