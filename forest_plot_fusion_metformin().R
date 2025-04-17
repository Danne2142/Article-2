library(ggplot2)
library(dplyr)
library(patchwork)

forest_plot_fusion_metformin <- function(df1, df2, df3,
                                source_names = c("Source1", "Source2", "Source3"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", vertical_line = 0,
                                plot_size = NULL,  # new optional argument for plot text size
                                ...) {
  df1$Source <- as.character(source_names[1])
  df2$Source <- as.character(source_names[2])
  df3$Source <- as.character(source_names[3])
  
  fused_df <- bind_rows(df1, df2, df3)
  
  # Convert Source to a factor with levels matching your source_names
  fused_df$Source <- factor(fused_df$Source, levels = source_names)
  
  p <- plot_forest(fused_df, estimate_col = "estimate", conf.low_col = "2.5 %", 
conf.high_col = "97.5 %", label_col = "group", pvalue_col = "p.value", xlab = xlab, ylab = ylab, vertical_line = vertical_line, ...)
  p <- p + scale_color_manual(name = "Biomarker", 
                              values = setNames(color_values, source_names),
                              guide = guide_legend(override.aes = list(label = "")))
  # Adjust plot size if plot_size parameter is provided
  if (!is.null(plot_size)) {
    p <- p + theme(text = element_text(size = plot_size))
  }
  
  return(p)
}

