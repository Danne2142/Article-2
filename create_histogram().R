create_histogram <- function(df, column, bins = 30, main_title = "Histogram", 
                             x_label = "Values", y_label = "Frequency", 
                             num_ticks = 10) {
  # Check if the column exists in the df frame
  if (!column %in% names(df)) {
    stop("The specified column does not exist in the df frame.")
  }
  
  # Extract the data for the column
  column_data <- df[[column]]
  
  # Ensure the data is numeric
  if (!is.numeric(column_data)) {
    stop("The specified column must be numeric.")
  }
  
  # Create the histogram without the X-axis
  hist(
    column_data,
    breaks = bins,
    main = main_title,
    xlab = x_label,
    ylab = y_label,
    col = "lightblue",
    border = "black",
    xaxt = "n"  # Suppress the default X-axis
  )
  
  # Determine the range of the data
  data_min <- min(column_data, na.rm = TRUE)
  data_max <- max(column_data, na.rm = TRUE)
  
  # Calculate pretty breakpoints for the X-axis
  tick_positions <- pretty(c(data_min, data_max), n = num_ticks)
  
  # Add the customized X-axis with more tick marks
  axis(
    side = 1,          # 1 = X-axis
    at = tick_positions,
    labels = TRUE,
    las = 1            # Make labels horizontal
  )
}