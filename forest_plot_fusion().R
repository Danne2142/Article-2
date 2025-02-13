library(ggplot2)
library(dplyr)
library(patchwork)

forestplot_fusion <- function(df1, df2, df3,
                                source_names = c("Source1", "Source2", "Source3"),
                                color_values = c("red", "blue", "green"),
                                xlab = "", ylab = "", ...) {
  df1$Source <- as.character(source_names[1])
  df2$Source <- as.character(source_names[2])
  df3$Source <- as.character(source_names[3])
  
  fused_df <- bind_rows(df1, df2, df3)
  
  # Convert Source to a factor with levels matching your source_names
  fused_df$Source <- factor(fused_df$Source, levels = source_names)
  
  p <- plot_forest(fused_df, xlab = xlab, ylab = ylab, ...)
  p <- p + scale_color_manual(name = "Biomarker", 
                              values = setNames(color_values, source_names),
                              guide = guide_legend(override.aes = list(label = "")))
  return(p)
}