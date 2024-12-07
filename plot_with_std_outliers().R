plot_with_std_outliers <- function(data, outliers_std_thresh, col_num) {
  # Check if the column number is valid
  if (!is.numeric(col_num) || col_num < 1 || col_num > ncol(data)) {
    stop("Invalid column number.")
  }
  
  # Extract the column data
  variable <- data[[col_num]]
  
  # Check if the variable is numeric
  if (!is.numeric(variable)) {
    stop("Selected column is not numeric.")
  }
  
  # Remove NA values for accurate calculations
  variable_clean <- variable[!is.na(variable)]
  
  # Calculate mean and standard deviation
  var_mean <- mean(variable_clean)
  var_sd <- sd(variable_clean)
  
  # Define outlier thresholds
  upper_thresh <- var_mean + outliers_std_thresh * var_sd
  lower_thresh <- var_mean - outliers_std_thresh * var_sd
  
  # Determine y-axis limits to include all data points
  y_min <- min(variable_clean, lower_thresh)
  y_max <- max(variable_clean, upper_thresh)
  
  # Create boxplot with adjusted ylim and suppress outliers
  boxplot(variable, main = paste("Boxplot of", names(data)[col_num]),
          ylab = names(data)[col_num], 
          col = "lightblue", border = "darkblue",
          outline = FALSE,  # Suppress default outliers
          ylim = c(y_min, y_max))
  
  # Add lines for outlier thresholds
  abline(h = upper_thresh, col = "red", lty = 2, lwd = 2)
  abline(h = lower_thresh, col = "red", lty = 2, lwd = 2)
  
  # Overlay individual data points as a stripchart
  stripchart(variable, vertical = TRUE, method = "jitter",
             pch = 21, col = "darkgreen", bg = rgb(0, 1, 0, 0.5),  # Semi-transparent green
             add = TRUE, 
             jitter = 0.1, cex = 0.7)  # Adjust jitter and size as needed
  
  # Add legend
  legend("topright", 
         legend = c(paste("Outlier Threshold ±", outliers_std_thresh, "SD"),
                    "Individual Data Points"),
         col = c("red", "darkgreen"), 
         pch = c(NA, 21), 
         pt.bg = c(NA, rgb(0, 1, 0, 0.5)),
         lty = c(2, NA), 
         lwd = c(2, NA),
         bty = "n")
}
