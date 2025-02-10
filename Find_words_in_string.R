# Define a function to check for searchwords in a text
find_keywords <- function(searchword_string, text) {
  # Split the string into individual keywords
  keywords <- unlist(strsplit(searchword_string, "\\|"))
  keywords <- trimws(keywords)  # remove any extra whitespace
  # Check which keywords are present in the text (ignoring case)
  found <- keywords[sapply(keywords, function(word) grepl(word, text, ignore.case = TRUE))]
  if(length(found) > 0) {
    return(found)
  } else {
    return(character(0))
  }
}

# Example usage
searchword_string <- "HRT|Estrogen|Estradiol|Alora|Cenestin|Climara|Divigel|Elestrin|Enjuvia|Esclim|Estrace|Estraderm|Estrasorb|EstroGel|Evamist|Femtrace|Menest|Menostar|Minivelle|Ogen|Ortho-est|Osphena|Premarin|Vivelle|Activella|Angeliq|ClimaraPro|Femhrt|Prefest|Prempro|Duavee|Estriol|TRT|testosterone|Androforte|Testorone|Cypionate|Androderm|AndroGel|Aveed|undecanoate|Depo-Testosterone|Fortesta|Jatenzo|Kyzatrex|undecanoate|Natesto|Testim|Testopel|Tlando|Vogelxo|Xyosted|enanthate"
text_to_check <- "Astaxanthin; B12; Coenzyme Q10; Fisetin; Fish Oil/ Omega-3 Fatty Acids; Vitamin C; Vitamin D;Pycnogenol 100 mg, TMG 750 mg

"

found_keywords <- find_keywords(searchword_string, text_to_check)

if(length(found_keywords) > 0){
  cat("Found keywords:", paste(found_keywords, collapse = ", "))
} else {
  cat("No keywords found.")
}