plot_forest <- function(df, estimate_col = "estimate", conf.low_col = "2.5 %", conf.high_col = "97.5 %", label_col = "term", group_col = NULL, pvalue_col = "p.value") {
  # Ensure ggplot2 and dplyr are loaded
  library(ggplot2)
  library(dplyr)
  
  # Convert input column names to symbols for ggplot
  estimate <- sym(estimate_col)
  conf_low <- sym(conf.low_col)
  conf_high <- sym(conf.high_col)
  label <- sym(label_col)
  
  # Check if pvalue_col exists in df
  if(!pvalue_col %in% colnames(df)) {
    stop(paste("The p-value column", pvalue_col, "is not in the dataframe."))
  }
  pvalue <- sym(pvalue_col)
  
  # If a grouping column is provided, arrange data by that column and term
  if(!is.null(group_col) && group_col %in% colnames(df)) {
    df <- df %>%
      arrange(!!sym(group_col), !!label)
    # Convert the grouping column to factor for consistent ordering
    df[[group_col]] <- as.factor(df[[group_col]])
  } else {
    # Arrange data by the label column only
    df <- df %>%
      arrange(!!label)
  }
  
  # Calculate x positions for text labels
  x_max <- max(df[[conf.high_col]], na.rm = TRUE)
  x_min <- min(df[[conf.low_col]], na.rm = TRUE)
  x_range <- x_max - x_min
  
  df <- df %>%
    mutate(
      p_label = paste0("p = ", signif(.[[pvalue_col]], 2)),
      text_x = !!conf_high + 0.05 * x_range
    )
  
  # Create the forest plot
  p <- ggplot(df, aes(x = !!estimate, y = reorder(!!label, !!estimate))) +
    geom_point(color = "blue", size = 3) +
    geom_errorbarh(aes(xmin = !!conf_low, xmax = !!conf_high), height = 0.2, color = "blue") +
    geom_text(aes(x = text_x, label = p_label), hjust = 0, size = 3) +
    geom_vline(xintercept = 0, linetype = "dashed", color = "red") +
    expand_limits(x = x_max + 0.2 * x_range) +
    labs(
      x = "Estimate with 95% CI",
      y = "Term",
      title =  df$Outcome[1]
    ) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 10))
  
  # If a grouping column is provided, facet the plot by that group
  if(!is.null(group_col) && group_col %in% colnames(df)) {
    p <- p + facet_wrap(as.formula(paste("~", group_col)), scales = "free_y", ncol = 1)
  }
  
  return(p)
}
