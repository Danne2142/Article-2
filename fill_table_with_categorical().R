fill_table_with_categorical <- function(df, categorical_var, outcome_column, young_old_boundary, 
                                        test_type = c("fisher", "chi"), use_only_categories = NULL, 
                                        print_all_categories = FALSE, display_only_true_vales = FALSE, replace_small_counts = FALSE, prefix = "") {
  library(dplyr)
  
  # Print available categories if wanted
  if (print_all_categories == TRUE) {
    freq_table <- table(df[[categorical_var]])
    print("Available categories: ")
    print(freq_table)
  }
  
  # Choose dataframe layout
  table <- data.frame("Variable" = character(), "Old" = character(), "Young" = character(), "p-value" = character(), stringsAsFactors = FALSE)
  
  # Define Function to filter a specified categorical column based on a list of allowed values
  filter_categorical <- function(df, allowed_values, categorical) {
    # Dynamically reference the column using df[[categorical]]
    df[[categorical]] <- ifelse(df[[categorical]] %in% allowed_values, df[[categorical]], NA)
    return(df)
  }
  
  if (!is.null(use_only_categories)) {
    df <- arrange(filter_categorical(df, use_only_categories, categorical_var), categorical_var)
  }
  
  # Ensure test_type is one of the allowed values
  test_type <- match.arg(test_type, choices = c("fisher", "chi", "fisher_simulate"), several.ok = TRUE)  # Handle multiple choices if needed  
  
  # Split the dataframe into "young" and "old" based on the outcome_column
  young <- df[df[[outcome_column]] < young_old_boundary, ]
  old <- df[df[[outcome_column]] >= young_old_boundary, ]
  
  # Get the unique levels of the categorical variable
  levels_var <- sort(unique(df[[categorical_var]]))
  
  # Initialize a matrix to store counts for the test
  count_matrix <- matrix(nrow = length(levels_var), ncol = 2)
  
  # Initialize a list to store the row data for the table
  table_rows <- list()
  
  # Iterate over each level and calculate counts and percentages
  for (i in seq_along(levels_var)) {
    level <- levels_var[i]
    
    young_level <- young %>% filter(!!sym(categorical_var) == level)
    old_level <- old %>% filter(!!sym(categorical_var) == level)
    
    count_young <- nrow(young_level)
    count_old <- nrow(old_level)
    
    percent_young <- round(100 * count_young / nrow(young), digits = 1)
    percent_old <- round(100 * count_old / nrow(old), digits = 1)
    
    # Add the counts to the matrix for the test
    count_matrix[i, ] <- c(count_old, count_young)
    
    # Replace counts less than 5 with "<5" if replace_small_counts is TRUE
    if (replace_small_counts == TRUE) {
      display_count_old <- ifelse(count_old > 0 & count_old < 5, "<5", as.character(count_old))
      display_count_young <- ifelse(count_young > 0 & count_young < 5, "<5", as.character(count_young))
    } else {
      display_count_old <- as.character(count_old)
      display_count_young <- as.character(count_young)
    }
    
    # Add the formatted data to the table rows
    table_rows[[i]] <- c(paste("  ", level),
                         paste(display_count_old, " (", percent_old, ")", sep = ""),
                         paste(display_count_young, " (", percent_young, ")", sep = ""),
                         "")
  }
  
  # Handle missing values
  is_na_young <- young %>% filter(is.na(!!sym(categorical_var)))
  is_na_old <- old %>% filter(is.na(!!sym(categorical_var)))
  
  count_na_young <- nrow(is_na_young)
  count_na_old <- nrow(is_na_old)
  
  if (count_na_young > 0 || count_na_old > 0) {
    percent_na_young <- round(100 * count_na_young / nrow(young), digits = 1)
    percent_na_old <- round(100 * count_na_old / nrow(old), digits = 1)
    
    # Add the counts for missing values to the matrix for the test
    count_matrix <- rbind(count_matrix, c(count_na_old, count_na_young))
    
    # Replace counts less than 5 with "<5" if replace_small_counts is TRUE
    if (replace_small_counts == TRUE) {
      display_count_na_old <- ifelse(count_na_old > 0 & count_na_old < 5, "<5", as.character(count_na_old))
      display_count_na_young <- ifelse(count_na_young > 0 & count_na_young < 5, "<5", as.character(count_na_young))
    } else {
      display_count_na_old <- as.character(count_na_old)
      display_count_na_young <- as.character(count_na_young)
    }
    
    # Add missing values to the table rows
    table_rows[[length(levels_var) + 1]] <- c("   Missing",
                                              paste(display_count_na_old, " (", percent_na_old, ")", sep = ""),
                                              paste(display_count_na_young, " (", percent_na_young, ")", sep = ""),
                                              "")
  }
  
  # Remove rows with all zeros from the count_matrix
  count_matrix <- count_matrix[rowSums(count_matrix) > 0, , drop = FALSE]
  
  # Ensure count_matrix has at least 2 rows and 2 columns before performing the test
  if (nrow(count_matrix) < 2 || ncol(count_matrix) < 2) {
    warning("The contingency table must have at least 2 rows and 2 columns for statistical testing.")
    return(table)
  }
  
  # Print the contingency table with categorical_var included
  cat("Contingency Table for", categorical_var, " with the chosen categories:\n")
  print(count_matrix)
  
  # Perform the chosen test
  if (test_type == "fisher") {
    test_result <- fisher.test(count_matrix, simulate.p.value = FALSE)
  } else if (test_type == "fisher_simulate") {
    test_result <- fisher.test(count_matrix, simulate.p.value = TRUE, B = 1e4)  # Use 10,000 simulations
  } else if (test_type == "chi") {
    test_result <- chisq.test(count_matrix)
  }
  
  if (display_only_true_vales == TRUE) {
    table[nrow(table) + 1, ] <- c(paste(prefix, categorical_var, ", n, (%)"),
                                  table_rows[[2]][[2]], table_rows[[2]][[3]],
                                  format_pvalue(test_result$p.value))  # The second row will always be the True values because the categories are sorted alphabetically
  } else {
    # Add the rows to the table
    table[nrow(table) + 1, ] <- c(paste(prefix, categorical_var, "level, n, (%)"), "", "", format_pvalue(test_result$p.value))
    
    for (row in table_rows) {
      table[nrow(table) + 1, ] <- row
    }
  }
  return(table)
}
