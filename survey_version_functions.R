seperate_survey <- function(df, cols) {
  # Ensure the specified columns exist in the data frame
  valid_cols <- cols[cols %in% names(df)]
  
  print("Valid cols: ")
  print(valid_cols)
  
  
  # If there are no valid columns, return both data frames as empty
  if (length(valid_cols) == 0) {
    return(list(filtered = data.frame(), removed = df))
  }
  
  # Create a logical vector indicating which rows to keep
  keep_rows <- apply(df[valid_cols], 1, function(row) any(!is.na(row) & row != ""))
  
  # Print how many hits each column generated
  for (col in valid_cols) {
    hits <- sum(!is.na(df[[col]]) & df[[col]] != "")
    cat("Column", col, "has", hits, "hits.\n")
  }
  
  # Subset the original data frame based on the logical vector
  df_filtered <- df[keep_rows, , drop = FALSE]
  df_removed <- df[!keep_rows, , drop = FALSE]
  
  # Return both data frames as a list
  return(list(survey_with_cols = df_filtered, survey_without_cols = df_removed))
}


add_surv_version_col <- function(df, cols_survey2_3, cols_survey3_1) {
  
  # Seperate survey1
  print("")
  print("Identifying survey 1")
  survey1 <<- seperate_survey(df, cols_survey2_3)$survey_without_cols
  survey2_3 <<- seperate_survey(df, cols_survey2_3)$survey_with_cols
  
  # Ensure surveys have data before proceeding
  if (nrow(survey1) > 0) {
    survey1$survey_version <- 1
  } else {
    survey1 <- data.frame()
  }
  print("")
  print("Identifying survey 3 from surveys 2/3")
  survey3 <<- seperate_survey(survey2_3, cols_survey3_1)$survey_with_cols
  survey2 <<- seperate_survey(survey2_3, cols_survey3_1)$survey_without_cols
  
  if (nrow(survey2) > 0) {
    survey2$survey_version <- 2
  } else {
    survey2 <- data.frame()
  }
  
  if (nrow(survey3) > 0) {
    survey3$survey_version <- 3
  } else {
    survey3 <- data.frame()
  }
  
  # Bind surveys rowwise
  combined_survey <- dplyr::bind_rows(survey1, survey2, survey3)
  
  return(combined_survey)
}