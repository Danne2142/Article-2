
mixed_correlation_matrix <- function(df, cols_to_skip = NULL) {
  # Load necessary packages
  if (!requireNamespace("vcd", quietly = TRUE)) {
    install.packages("vcd")
  }
  library(vcd)
  
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    install.packages("ggplot2")
  }
  library(ggplot2)
  
  if (!requireNamespace("reshape2", quietly = TRUE)) {
    install.packages("reshape2")
  }
  library(reshape2)
  
  # Remove columns to skip
  if (!is.null(cols_to_skip)) {
    df <- df[ , !(names(df) %in% cols_to_skip)]
    message(sprintf("Skipping columns: %s", paste(cols_to_skip, collapse = ", ")))
  }
  
  # Print the columns being processed
  message("Processing columns:")
  print(names(df))
  
  # Get the number of variables
  vars <- names(df)
  n <- length(vars)
  
  # Initialize matrices to store correlation coefficients and methods
  cor_matrix <- matrix(NA, nrow = n, ncol = n)
  rownames(cor_matrix) <- vars
  colnames(cor_matrix) <- vars
  
  method_matrix <- matrix("", nrow = n, ncol = n)
  rownames(method_matrix) <- vars
  colnames(method_matrix) <- vars
  
  # Loop over each pair of variables
  for (i in 1:n) {
    for (j in i:n) {
      var1 <- df[[i]]
      var2 <- df[[j]]
      var1_name <- vars[i]
      var2_name <- vars[j]
      
      message(sprintf("Computing correlation between '%s' (%s) and '%s' (%s)", 
                      var1_name, class(var1), var2_name, class(var2)))
      
      # Handle missing values
      complete_cases <- complete.cases(var1, var2)
      var1_clean <- var1[complete_cases]
      var2_clean <- var2[complete_cases]
      
      # Determine appropriate method and compute correlation
      method <- NULL
      corr_value <- NA
      
      # Both variables are numeric
      if (is.numeric(var1_clean) && is.numeric(var2_clean)) {
        # Use Pearson correlation
        corr_value <- cor(var1_clean, var2_clean, method = "pearson")
        method <- "Pearson"
      }
      # Both variables are ordered factors
      else if (is.ordered(var1_clean) && is.ordered(var2_clean)) {
        # Use Spearman correlation
        corr_value <- cor(as.numeric(var1_clean), as.numeric(var2_clean), method = "spearman")
        method <- "Spearman"
      }
      # Both variables are unordered factors or logicals (nominal)
      else if ((is.factor(var1_clean) && !is.ordered(var1_clean) || is.logical(var1_clean)) && 
               (is.factor(var2_clean) && !is.ordered(var2_clean) || is.logical(var2_clean))) {
        # Use Cramér's V
        tbl <- table(var1_clean, var2_clean)
        if (min(dim(tbl)) > 1) {
          chi2 <- suppressWarnings(chisq.test(tbl, simulate.p.value = TRUE))
          n_cases <- sum(tbl)
          phi2 <- chi2$statistic / n_cases
          r <- nrow(tbl)
          k <- ncol(tbl)
          phi2corr <- max(0, phi2 - ((k - 1)*(r - 1))/(n_cases - 1))
          rcorr <- min(k - 1, r - 1)
          corr_value <- sqrt(phi2corr / rcorr)
          method <- "Cramér's V"
        } else {
          message(sprintf("Insufficient data to compute Cramér's V between '%s' and '%s'", var1_name, var2_name))
          method <- "NA"
          corr_value <- NA
        }
      }
      # One variable is numeric, one is ordered factor
      else if ((is.numeric(var1_clean) && is.ordered(var2_clean)) || 
               (is.ordered(var1_clean) && is.numeric(var2_clean))) {
        # Use Spearman correlation
        if (is.numeric(var1_clean)) {
          corr_value <- cor(var1_clean, as.numeric(var2_clean), method = "spearman")
        } else {
          corr_value <- cor(as.numeric(var1_clean), var2_clean, method = "spearman")
        }
        method <- "Spearman"
      }
      # One variable is numeric, one is binary factor or logical
      else if ((is.numeric(var1_clean) && (is.logical(var2_clean) || 
                                           (is.factor(var2_clean) && length(unique(var2_clean)) == 2 && !is.ordered(var2_clean)))) ||
               ((is.logical(var1_clean) || (is.factor(var1_clean) && length(unique(var1_clean)) == 2 && !is.ordered(var1_clean))) && 
                is.numeric(var2_clean))) {
        # Use Point-Biserial correlation
        if (is.numeric(var1_clean)) {
          var2_num <- ifelse(as.character(var2_clean) == as.character(unique(var2_clean))[1], 1, 0)
          corr_value <- cor(var1_clean, var2_num, method = "pearson")
        } else {
          var1_num <- ifelse(as.character(var1_clean) == as.character(unique(var1_clean))[1], 1, 0)
          corr_value <- cor(var1_num, var2_clean, method = "pearson")
        }
        method <- "Point-Biserial"
      }
      # One variable is ordered factor (ordinal), one is unordered factor (nominal)
      else if ((is.ordered(var1_clean) && is.factor(var2_clean) && !is.ordered(var2_clean)) ||
               (is.factor(var1_clean) && !is.ordered(var1_clean) && is.ordered(var2_clean))) {
        # Use Correlation Ratio (Eta)
        eta_sq <- function(x, group) {
          x_numeric <- as.numeric(x)
          group_factor <- as.factor(group)
          ss_total <- sum((x_numeric - mean(x_numeric))^2)
          ss_within <- sum(tapply(x_numeric, group_factor, function(g) sum((g - mean(g))^2)))
          eta_squared <- (ss_total - ss_within) / ss_total
          return(sqrt(eta_squared))
        }
        if (is.ordered(var1_clean) && is.factor(var2_clean) && !is.ordered(var2_clean)) {
          # var1 is ordinal, var2 is nominal
          corr_value <- eta_sq(var1_clean, var2_clean)
        } else {
          # var1 is nominal, var2 is ordinal
          corr_value <- eta_sq(var2_clean, var1_clean)
        }
        method <- "Eta"
      }
      # Other combinations are not handled
      else {
        message(sprintf("Cannot compute correlation between '%s' and '%s'", var1_name, var2_name))
        method <- "NA"
        corr_value <- NA
      }
      cor_matrix[i, j] <- corr_value
      cor_matrix[j, i] <- corr_value
      method_matrix[i, j] <- method
      method_matrix[j, i] <- method
    }
  }
  
  # Convert the correlation matrix to a data frame for plotting
  cor_df <- reshape2::melt(cor_matrix, varnames = c("Var1", "Var2"), value.name = "Correlation")
  
  # Add method information
  method_df <- reshape2::melt(method_matrix, varnames = c("Var1", "Var2"), value.name = "Method")
  cor_df$Method <- method_df$Method
  
  # # Plot the correlation matrix
  # plot <- ggplot(data = cor_df, aes(x = Var1, y = Var2, fill = Correlation)) +
  #   geom_tile(color = "white") +
  #   geom_text(aes(label = ifelse(!is.na(Correlation),
  #                                paste0(round(Correlation, 2), "\n", Method),
  #                                "")), size = 3) +
  #   scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
  #                        midpoint = 0, limit = c(-1, 1), space = "Lab", 
  #                        name="Correlation") +
  #   theme_minimal() + 
  #   theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
  #   labs(title = "Mixed Correlation Matrix", x = "", y = "") +
  #   coord_fixed()
  # 
  # print(plot)
  
  return(cor_df)
}