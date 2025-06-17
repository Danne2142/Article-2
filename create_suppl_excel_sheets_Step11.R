# -----------------------------------------------------------------------------
# create_suppl_excel_sheets_Step11.R
# -----------------------------------------------------------------------------
# 
# This script creates supplementary Excel tables by combining multiple xlsx files 
# from different directories into consolidated output files.
#
# The script creates five different supplementary tables:
# 1. Supplementary Table 2: Main models results
# 2. Supplementary Table 3: Sex sensitivity analysis
# 3. Supplementary Table 4: Age sensitivity analysis
# 4. Supplementary Table 5: Metformin analysis results
# 5. Supplementary Table 6: Ethnicity sensitivity analysis
#
# For each table, the script:
# - Specifies an input directory containing xlsx files to be combined
# - Defines an output file path
# - Calls the combine_xlsx_files() function (imported from another script)
#   to merge the files and create the consolidated table
#
# Dependencies:
# - Requires the combine_xlsx_files() function defined in create_suppl_excel_sheets().R
#
# -----------------------------------------------------------------------------
source("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Program/create_suppl_excel_sheets().R")

# Create file for main models
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results"
# Specify the output file path
output_file <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/main_models_results/supplementary_table_2.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for sex
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/sex_sensitivity_analysis"
# Specify the output file path 
output_file <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/sex_sensitivity_analysis/supplementary_table_3.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for age
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis"
# Specify the output file path
output_file <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/supplementary_table_4.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for metformin
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results"
# Specify the output file path
output_file <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/metformin_analysis_results/supplementary_table_5.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)

# Create file for ethnicity
# Specify the directory containing your xlsx files
input_dir <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/ethnicity_sensitivity_analysis"
# Specify the output file path
output_file <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/ethnicity_sensitivity_analysis/supplementary_table_6.xlsx"
# Run the function
combine_xlsx_files(input_dir, output_file)
