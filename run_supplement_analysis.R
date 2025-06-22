# Test script to run the supplement histogram analysis
source("supplement_usage_histogram.R")

# Run the analysis with debug output
cat("Starting supplement usage analysis...\n")
results <- create_supplement_histograms()
