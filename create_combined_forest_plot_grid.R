library(pacman)
p_load(ggplot2, gridExtra, grid, png, jpeg)

# Function to load and prepare plots for grid arrangement
load_plot_image <- function(filepath) {
  if (file.exists(filepath)) {
    img <- readPNG(filepath)
    return(rasterGrob(img, interpolate = TRUE))
  } else {
    warning(paste("File not found:", filepath))
    return(NULL)
  }
}

# Define the paths to all forest plot figures
plot_paths <- list(
  # Sex sensitivity analysis
  males = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/sex_sensitivity_analysis/forest_plot_fusion_model3_only_males_z.png",
  females = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/sex_sensitivity_analysis/forest_plot_fusion_model3_only_females_z.png",
  
  # Age sensitivity analysis
  younger = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/forest_plot_fusion_model3_only_younger_z.png",
  older = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/age_sensitivity_analysis/forest_plot_fusion_model3_only_older_z.png",
  
  # Ethnicity sensitivity analysis (excluding "Other")
  european = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/ethnicity_sensitivity_analysis/forest_plot_fusion_model3_only_european_z.png",
  asian = "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/ethnicity_sensitivity_analysis/forest_plot_fusion_model3_only_asian_z.png"
)

# Load all plot images
plot_grobs <- list()
plot_labels <- c("A", "B", "C", "D", "E", "F")
plot_titles <- c("Males", "Females", "Younger", "Older", "European", "Asian")

for (i in 1:length(plot_paths)) {
  grob <- load_plot_image(plot_paths[[i]])
  if (!is.null(grob)) {
    plot_grobs[[i]] <- grob
  }
}

# Create the combined plot with 3x2 grid (3 rows, 2 columns)
create_combined_forest_plot <- function() {
  # Create an empty plot to serve as the base
  p <- ggplot() + 
    theme_void() +
    theme(plot.margin = margin(20, 20, 20, 20))
    # Arrange plots in a 3x2 grid (3 rows, 2 columns)
  combined_plot <- grid.arrange(
    grobs = plot_grobs,
    ncol = 2,  # 2 columns (Sex, Age, Ethnicity pairs)
    nrow = 3,  # 3 rows (Males/Females, Younger/Older, European/Asian)
    top = textGrob("Forest Plots: Sensitivity Analysis by Subgroups", 
                   gp = gpar(fontsize = 16, fontface = "bold")),
    bottom = textGrob("Model 3 Results for DunedinPACE, OMICmAge, and GrimAge", 
                      gp = gpar(fontsize = 12))
  )
  
  return(combined_plot)
}

# Function to add letter labels to each subplot
add_labels_to_grid <- function() {
  # Create the main combined plot
  png("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/combined_forest_plot_grid.png", 
      width = 12, height = 18, units = "in", res = 300)
  
  # Set up the layout - 3 rows, 2 columns
  layout_matrix <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3, ncol = 2, byrow = TRUE)
  layout(layout_matrix)
  
  # Plot each image with labels
  for (i in 1:length(plot_grobs)) {
    if (!is.null(plot_grobs[[i]])) {
      par(mar = c(2, 2, 3, 2))
      plot(0, 0, type = "n", axes = FALSE, xlab = "", ylab = "", 
           xlim = c(0, 1), ylim = c(0, 1))
      
      # Add the plot image
      grid.draw(plot_grobs[[i]])
      
      # Add letter label in top-left corner
      text(0.05, 0.95, plot_labels[i], 
           cex = 2, font = 2, col = "black", 
           adj = c(0, 1))
      
      # Add subtitle
      text(0.5, 0.02, plot_titles[i], 
           cex = 1.2, font = 2, col = "black", 
           adj = c(0.5, 0))
    }
  }
  
  dev.off()
}

# Alternative approach using ggplot2 and patchwork for better control
library(pacman)
p_load(patchwork, magick)

create_labeled_forest_plot_grid <- function() {
  # Read images using magick
  plot_images <- list()
  
  for (i in 1:length(plot_paths)) {
    if (file.exists(plot_paths[[i]])) {
      img <- image_read(plot_paths[[i]])
      plot_images[[i]] <- img
    }
  }
  
  # Convert to ggplot objects
  gg_plots <- list()
  for (i in 1:length(plot_images)) {
    if (!is.null(plot_images[[i]])) {
      # Create a ggplot with the image
      gg_plots[[i]] <- ggplot() +
        annotation_custom(rasterGrob(as.raster(plot_images[[i]]), 
                                   width = unit(1, "npc"), 
                                   height = unit(1, "npc"))) +
        xlim(0, 1) + ylim(0, 1) +
        theme_void() +
        theme(plot.margin = margin(5, 5, 5, 5)) +
        labs(title = paste0(plot_labels[i], ". ", plot_titles[i])) +
        theme(plot.title = element_text(size = 14, face = "bold", hjust = 0))
    }
  }
  
  # Combine using patchwork - 3 rows, 2 columns
  if (length(gg_plots) == 6) {
    combined <- (gg_plots[[1]] | gg_plots[[2]]) /
                (gg_plots[[3]] | gg_plots[[4]]) /
                (gg_plots[[5]] | gg_plots[[6]])
    
    # Add main title
    final_plot <- combined + 
      plot_annotation(
        title = "Forest Plots: Sensitivity Analysis by Subgroups",
        subtitle = "Model 3 Results for DunedinPACE, OMICmAge, and GrimAge",
        theme = theme(plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
                     plot.subtitle = element_text(size = 14, hjust = 0.5))
      )
    
    # Save the plot
    ggsave("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/combined_forest_plot_grid.png", 
           final_plot, width = 12, height = 18, dpi = 300, bg = "white")
    
    return(final_plot)
  }
}

# Execute the function to create the combined plot
print("Creating combined forest plot grid...")

# Try the patchwork approach first (recommended)
tryCatch({
  final_plot <- create_labeled_forest_plot_grid()
  print("Combined forest plot saved successfully using patchwork!")
  print(final_plot)
}, error = function(e) {
  print(paste("Patchwork approach failed:", e$message))
  print("Trying alternative approach...")
  
  # Fallback to basic grid approach
  tryCatch({
    add_labels_to_grid()
    print("Combined forest plot saved successfully using base R grid!")
  }, error = function(e2) {
    print(paste("Grid approach also failed:", e2$message))
    print("Please check that all input files exist and required packages are installed.")
  })
})

print("Script completed. Check the output file at:")
print("C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Output/combined_forest_plot_grid.png")
