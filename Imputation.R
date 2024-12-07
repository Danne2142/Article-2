## File name: projImputation
## Study: frailty - NEAR
## Author: Thais Lopes de Oliveira. thais.lopes.de.oliveira@ki.se
## Date: March 26, 2024.
## Updated: 
## Note:  imputation




# checking % of missing  ----------------------------------------------


aggr_plot <- VIM::aggr(df, col=c('green','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, 
                       ylab=c("Proportion of missing","Missing pattern with proportion"))  #### Green is observed and red is missing.




# imputation --------------------------------------------------------------
library(mice)

start <- Sys.time()
df_imp <- mice(df, seed=12345, m=10, maxit=65, print=FALSE,tol = 1e-17) # imputes 10 different datasets
running_time = Sys.time() - start
print(running_time) # check how long it runs
df_imp$loggedEvents # if you need to check if something went wrong


# inspecting imputed data -------------------------------------------------

densityplot(df_imp)
stripplot(df_imp)
