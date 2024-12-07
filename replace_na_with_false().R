replace_na_with_false <- function(df, column_name) {
  df[[column_name]][is.na(df[[column_name]])] <- FALSE
  return(df)
}

# # Example usage
# df <- data.frame(
#   ID = 1:5,
#   Status = c(TRUE, NA, FALSE, NA, TRUE)
# )
# 
# df <- replace_na_with_false(df, "Status")
# print(df)
