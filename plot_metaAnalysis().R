plot_metaAnalysis<-function(meta_df=NULL, xlabel="", ylabel="", vertical_line_value=0, model_name = NULL, savePath = NULL) {
    results_plt<-plot_forest(df=meta_df, estimate_col = "Estimate", conf.low_col = "lower_CI", conf.high_col = "upper_CI", label_col = "Term", group_col = NULL, pvalue_col = "effects", xlab = xlabel, ylab = ylabel, vertical_line = vertical_line_value) 
    print(results_plt)
    ggsave(paste0(savePath, "meta_plot", model_name, ".png"), plot = results_plt)
}