# Load UpSetR package
library(UpSetR)

data <- read.csv("C:/Users/danwik/OneDrive - Karolinska Institutet/Desktop/Project 2 ny/Output/filtered_df_crossectional_harmonized", header=TRUE, stringsAsFactors=FALSE)

# Function to convert TRUE/FALSE to 1/0 and NA to 0
convert_bool_to_numeric <- function(data, columns) {
  for (col in columns) {
    print(col)
    if (is.logical(data[[col]])) {
      data[[col]] <- as.numeric(data[[col]])  # TRUE to 1, FALSE to 0
      data[[col]][is.na(data[[col]])] <- 0    # Convert NA to 0
    } else {
      print(paste(col, "is not a logical column and will not be converted."))
    }
  }
  return(data)
}
# columns_to_convert <- c("NAD", "Antiaging.NAD")

columns_to_convert <- c("NAD", "Sulforaphane", "DHEA", "Rapamycin","SASP_supressors","Resveratrol", "Metformin", "Exosomes", "Stem_cells", "HRT",
                        "Spermidine", "Fasting","semaglutide", "VitaminD", "AKG")
data<- convert_bool_to_numeric(data, columns_to_convert)



# Create and customize UpSet plot
upset(data,
      sets = columns_to_convert,  # Use column names directly
      order.by = "freq",
      # min_size = 100,
      # nintersects = 70,
      main.bar.color = "black",
      sets.bar.color = "black",
      nsets = length(columns_to_convert),
      number.angles = 30,
      point.size = 3.5,
      line.size = 2,
      # mb.ratio = c(0.6, 0.4),
      text.scale = c(2, 2, 2, 1, 2, 1))
# 
# upset(data,
#       sets = c("Set1", "Set2", "Set3", "Set4"),
#       order.by = "freq",
#       main.bar.color = "blue",
#       sets.bar.color = "red",
#       nsets = 4,
#       number.angles = 30,
#       point.size = 3.5,
#       line.size = 2,
#       mb.ratio = c(0.6, 0.4),
#       text.scale = c(2, 2, 2, 1, 2, 2))
# 
# set_sizes <- colSums(data)
# print(set_sizes)