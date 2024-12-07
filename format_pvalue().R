### Handle p-values

format_pvalue <- function(pvalue){
  
  if (pvalue>0.01){return(round(pvalue,digits=2))}
  if (pvalue<0.01){return("P < 0.01")}
  if (pvalue<0.001){return("P < 0.001")}
}