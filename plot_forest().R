plot_forest <- function(df, estimate_col = "estimate", conf.low_col = "2.5 %", conf.high_col = "97.5 %", label_col = "term", group_col = NULL, pvalue_col = "p.value", xlab = "", ylab = "", vertical_line = 0) {
  library(ggplot2)
  library(dplyr)
  
  estimate <- sym(estimate_col)
  conf_low <- sym(conf.low_col)
  conf_high <- sym(conf.high_col)
  label <- sym(label_col)
  
  if(!pvalue_col %in% colnames(df)) {
    stop(paste("The p-value column", pvalue_col, "is not in the dataframe."))
  }
  pvalue <- sym(pvalue_col)
  
  if(!is.null(group_col) && group_col %in% colnames(df)) {
    df <- df %>% arrange(!!sym(group_col), !!label)
    df[[group_col]] <- as.factor(df[[group_col]])
  } else {
    df <- df %>% arrange(!!label)
  }
  
  # Determine x-axis range for later use
  x_max <- max(df[[conf.high_col]], na.rm = TRUE)
  x_min <- min(df[[conf.low_col]], na.rm = TRUE)
  x_range <- x_max - x_min
  
  df <- df %>% 
    mutate(
      p_label = paste0("p = ", if(is.numeric(.[[pvalue_col]])) signif(.[[pvalue_col]], 2) else .[[pvalue_col]]),
      text_x = !!conf_high + 0.05 * x_range
    )
  
  # When a Source column exists, adjust vertical positions to avoid overlap.
  if("Source" %in% names(df)) {
    df <- df %>% 
      mutate(
        # Base numeric position for each term (each term may appear multiple times)
        base_y = as.numeric(factor(!!label, levels = unique(!!label))),
        # Compute an offset based on the Source (centered around 0). Adjust multiplier (e.g., 0.15) for spacing.
        source_offset = as.numeric(Source) - (length(unique(Source)) + 1) / 2,
        ypos = base_y + source_offset * 0.15
      )
    
    p <- ggplot(df, aes(x = !!estimate, y = ypos, color = Source)) +
      geom_point(size = 3) +
      geom_errorbarh(aes(xmin = !!conf_low, xmax = !!conf_high), height = 0.1) +
      geom_text(aes(x = text_x, label = p_label), hjust = 0, size = 3, show.legend = FALSE) +
      # Replace y-axis labels with the term names (centered on each base_y)
      scale_y_continuous(breaks = unique(df$base_y),
                         labels = unique(df[[as.character(label)]]))
  } else {
    p <- ggplot(df, aes(x = !!estimate, y = reorder(!!label, !!estimate))) +
      geom_point(color = "blue", size = 3) +
      geom_errorbarh(aes(xmin = !!conf_low, xmax = !!conf_high), height = 0.2, color = "blue") +
      geom_text(aes(x = text_x, label = p_label), hjust = 0, size = 3, show.legend = FALSE)
  }
  
  p <- p +
    geom_vline(xintercept = vertical_line, linetype = "dashed", color = "red") +
    expand_limits(x = x_max + 0.2 * x_range) +
    labs(x = xlab, y = ylab) +
    theme_minimal() +
    theme(axis.text.y = element_text(size = 10))
  
  if(!is.null(group_col) && group_col %in% colnames(df)) {
    p <- p + facet_wrap(as.formula(paste("~", group_col)), scales = "free_y", ncol = 1)
  }

  return(p)
}
