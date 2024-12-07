# Define the function
handle_hours_sedentary_remaining_awake <- function(data, column_name) {
  # Check if the specified column exists in the data frame
  if (!column_name %in% names(data)) {
    stop("The specified column does not exist in the data frame.")
  }
  
  # Ensure the specified column is numeric
  if (!is.numeric(data[[column_name]])) {
    stop("The specified column is not numeric.")
  }
  
  # Calculate the quartiles, excluding NA values
  quartiles <- quantile(
    data[[column_name]],
    probs = c(0.25, 0.50, 0.75),
    na.rm = TRUE
  )
  q25 <- quartiles[1]
  print(paste0("q25: ", q25))
  q50 <- quartiles[2]
  print(paste0("q50: ", q50))
  q75 <- quartiles[3]
  print(paste0("q75: ", q75))
  
  # Assign activity levels based on quartiles
  x <- data[[column_name]]
  sedentary_level <- rep(NA_real_, length(x))
  sedentary_level[is.na(x)] <- NA_real_  # Preserve NA values
  sedentary_level[x < q25] <- 0
  sedentary_level[x >= q25 & x < q50] <- 1
  sedentary_level[x >= q50 & x < q75] <- 2
  sedentary_level[x >= q75] <-3
  
  # Add the sedentary_level column to the data frame
  data$sedentary_level <- sedentary_level
  
  # Return the modified data frame
  return(data)
}