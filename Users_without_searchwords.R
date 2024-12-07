# Load necessary library
library(data.table)

# Define the file path
file_path <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/df_EPICv1_old_with_all_collumns.csv"

# Load the dataframe
df <- fread(file_path)

# Check the structure of the data (optional, just for understanding)
str(df)

# Count rows where either "NR.NAD" or "Antiaging.NAD" is TRUE
true_count <- sum(df$NR.NAD | df$Antiaging.NAD, na.rm = TRUE)

# Print the result
print(paste("Number of rows with TRUE in either 'NR.NAD' or 'Antiaging.NAD':", true_count))
