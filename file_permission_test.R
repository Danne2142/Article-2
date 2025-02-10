file_path <- "C:/Users/danwik/OneDrive - Karolinska Institutet/Documents/Project 2 - Vscode/Data/EPICv1 and v2 data/All_metrics_crossectional_samples.csv"

if (file.exists(file_path)) {
  print("The file exists.")
  if (file.access(file_path, 4) == 0) {
    print("You have read permission for this file.")
  } else {
    stop("The file exists but you do not have read permission!")
  }
} else {
  stop("The file does not exist!")
}