count_outliers <- function(df, outliers_std_thresh, cols_to_exclude = c()) {
  # Exclude specified columns
  df_filtered <- df[ , !(names(df) %in% cols_to_exclude)]
  
  # Select numeric columns
  num_cols <- sapply(df_filtered, is.numeric)
  df_num <- df_filtered[ , num_cols]
  
  # Exclude columns filled with 0, 1, and/or NA
  is_0_1_NA <- function(x) {
    all(is.na(x) | x == 0 | x == 1)
  }
  non_0_1_cols <- sapply(df_num, function(x) !is_0_1_NA(x))
  df_num_filtered <- df_num[ , non_0_1_cols]
  
  # Function to count outliers in a column
  count_outliers_in_column <- function(x, outliers_std_thresh) {
    x_non_na <- x[!is.na(x)]
    m <- mean(x_non_na)
    s <- sd(x_non_na)
    lower_thresh <- m - outliers_std_thresh * s
    upper_thresh <- m + outliers_std_thresh * s
    lower_count <- sum(x_non_na < lower_thresh)
    upper_count <- sum(x_non_na > upper_thresh)
    return(c(lower_count = lower_count, upper_count = upper_count))
  }
  
  # Apply the function to each column
  outlier_counts <- t(sapply(df_num_filtered, count_outliers_in_column, outliers_std_thresh = outliers_std_thresh))
  outlier_counts_df <- as.data.frame(outlier_counts)
  
  # Add variable names
  outlier_counts_df$variable <- rownames(outlier_counts_df)
  
  # Reorder columns if needed
  outlier_counts_df <- outlier_counts_df[ , c('variable', 'lower_count', 'upper_count')]
  
  # Return the data frame
  return(outlier_counts_df)
}
# 

