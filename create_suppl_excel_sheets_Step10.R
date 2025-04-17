

source("C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/create_suppl_excel_sheets().R")

# Create file for main models
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results"
# Specify the output file path
output_file <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/supplementary_table_2.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for sex
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/sex_sensitivity_analysis"
# Specify the output file path
output_file <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/sex_sensitivity_analysis/supplementary_table_3.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for age
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis"
# Specify the output file path
output_file <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/supplementary_table_4.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for metformin
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results"
# Specify the output file path
output_file <- "C:/Users/danie/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/supplementary_table_5.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)
