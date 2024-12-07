count_zero_and_negatives <- function(data, 
                                     exclude_cols) {
  
  # Ensure exclude_cols are present in data
  exclude_cols <- intersect(exclude_cols, names(data))
  
  # Step 1: Select numeric and integer columns
  numeric_cols <- sapply(data, function(col) is.numeric(col) || is.integer(col))
  
  # Step 2: Exclude specified columns
  selected_cols <- setdiff(names(data)[numeric_cols], exclude_cols)
  
  # Step 3: Exclude binary columns (only 0 and 1, ignoring NAs)
  non_binary_cols <- selected_cols[sapply(data[selected_cols], function(col) {
    unique_vals <- unique(col[!is.na(col)])  # Exclude NAs
    !all(unique_vals %in% c(0, 1))
  })]
  
  # Initialize a list to store results
  results <- lapply(non_binary_cols, function(col) {
    zero_numbers <- sum(data[[col]] == 0, na.rm = TRUE)
    negative_numbers <- sum(data[[col]] < 0, na.rm = TRUE)
    data.frame(
      column = col,
      zero_numbers = zero_numbers,
      negative_numbers = negative_numbers,
      stringsAsFactors = FALSE
    )
  })
  
  # Combine all results into a single data frame
  if(length(results) > 0){
    result_df <- do.call(rbind, results)
  } else {
    result_df <- data.frame(
      column = character(),
      zero_numbers = integer(),
      negative_numbers = integer(),
      stringsAsFactors = FALSE
    )
  }
  
  return(result_df)
}