### R code from vignette source 'bdsm_vignette.Rnw'

###################################################
### code chunk number 1: setup
###################################################
knitr::opts_chunk$set(
  fig.width = 5,
  fig.height = 3,
  dev = "pdf",
  dpi = 72
)


###################################################
### code chunk number 2: bdsm_vignette.Rnw:413-414 (eval = FALSE)
###################################################
## install.packages("bdsm")


###################################################
### code chunk number 3: bdsm_vignette.Rnw:417-418
###################################################
library(bdsm)


###################################################
### code chunk number 4: bdsm_vignette.Rnw:427-428
###################################################
economic_growth[1:12,1:10]


###################################################
### code chunk number 5: bdsm_vignette.Rnw:433-434
###################################################
original_economic_growth[1:12,1:10]


###################################################
### code chunk number 6: bdsm_vignette.Rnw:448-456
###################################################
economic_growth <- join_lagged_col(
  df            = original_economic_growth,
  col           = gdp,
  col_lagged    = lag_gdp,
  timestamp_col = year,
  entity_col    = country,
  timestep      = 10
)


###################################################
### code chunk number 7: bdsm_vignette.Rnw:473-477
###################################################
data_standardized_features <- feature_standardization(
    df            = economic_growth,
    excluded_cols = c(country, year, gdp)
  )


###################################################
### code chunk number 8: bdsm_vignette.Rnw:482-488
###################################################
data_prepared <- feature_standardization(
    df            = data_standardized_features,
    group_by_col  = year,
    excluded_cols = country,
    scale         = FALSE
  )


###################################################
### code chunk number 9: bdsm_vignette.Rnw:509-516 (eval = FALSE)
###################################################
## full_model_space <- optim_model_space(
##   df            = data_prepared,
##   dep_var_col   = gdp,
##   timestamp_col = year,
##   entity_col    = country,
##   init_value    = 0.5
## )


###################################################
### code chunk number 10: bdsm_vignette.Rnw:537-538
###################################################
full_model_space$params[1:10, 1:5]


###################################################
### code chunk number 11: bdsm_vignette.Rnw:554-555
###################################################
full_model_space$stats[, 1:5]


###################################################
### code chunk number 12: bdsm_vignette.Rnw:648-655 (eval = FALSE)
###################################################
## model_space <- optim_model_space(
##   df            = data_prepared,
##   dep_var_col   = gdp,
##   timestamp_col = year,
##   entity_col    = country,
##   init_value    = 0.5
## )


###################################################
### code chunk number 13: bdsm_vignette.Rnw:664-670 (eval = FALSE)
###################################################
## library(parallel)
## # Here we try to use all available cores on the system.
## # You might want to lower the number of cores depending on your needs.
## cores <- detectCores()
## cl <- makeCluster(cores)
## setDefaultCluster(cl)


###################################################
### code chunk number 14: bdsm_vignette.Rnw:675-683 (eval = FALSE)
###################################################
## model_space <- optim_model_space(
##   df            = data_prepared,
##   dep_var_col   = gdp,
##   timestamp_col = year,
##   entity_col    = country,
##   init_value    = 0.5,
##   cl            = cl
## )


###################################################
### code chunk number 15: bdsm_vignette.Rnw:711-712
###################################################
bma_results <- bma(full_model_space, df = data_prepared, round = 3)


###################################################
### code chunk number 16: bdsm_vignette.Rnw:720-721
###################################################
bma_results[[1]]


###################################################
### code chunk number 17: bdsm_vignette.Rnw:742-743
###################################################
bma_results[[2]]


###################################################
### code chunk number 18: bdsm_vignette.Rnw:757-758
###################################################
bma_results[[16]]


###################################################
### code chunk number 19: bdsm_vignette.Rnw:777-778
###################################################
for_models <- model_pmp(bma_results)


###################################################
### code chunk number 20: bdsm_vignette.Rnw:784-785
###################################################
for_models <- model_pmp(bma_results, top = 10)


###################################################
### code chunk number 21: bdsm_vignette.Rnw:804-805
###################################################
size_graphs <- model_sizes(bma_results)


###################################################
### code chunk number 22: bdsm_vignette.Rnw:833-835
###################################################
best_8_models <- best_models(bma_results, criterion = 1, best = 8)
best_8_models[[1]]


###################################################
### code chunk number 23: bdsm_vignette.Rnw:841-843
###################################################
best_3_models <- best_models(bma_results, criterion = 2, best = 3)
best_3_models[[5]]


###################################################
### code chunk number 24: bdsm_vignette.Rnw:852-854
###################################################
best_3_models <- best_models(bma_results, criterion = 2, best = 3)
best_3_models[[9]]


###################################################
### code chunk number 25: bdsm_vignette.Rnw:867-868
###################################################
jointness(bma_results)


###################################################
### code chunk number 26: bdsm_vignette.Rnw:878-879
###################################################
jointness(bma_results, measure = "LS")


###################################################
### code chunk number 27: bdsm_vignette.Rnw:887-888
###################################################
jointness(bma_results, measure = "DW")


###################################################
### code chunk number 28: bdsm_vignette.Rnw:906-908
###################################################
coef_plots <- coef_hist(bma_results)
coef_plots[[1]]


###################################################
### code chunk number 29: bdsm_vignette.Rnw:912-914
###################################################
coef_plots2 <- coef_hist(bma_results, kernel = 1)
coef_plots2[[1]]


###################################################
### code chunk number 30: bdsm_vignette.Rnw:918-921
###################################################
library(gridExtra)
grid.arrange(coef_plots[[1]], coef_plots[[2]], coef_plots2[[1]],
             coef_plots2[[2]], nrow = 2, ncol = 2)


###################################################
### code chunk number 31: bdsm_vignette.Rnw:939-940
###################################################
bma_results2 <- bma(full_model_space, df = data_prepared, round = 3, EMS = 2)


###################################################
### code chunk number 32: bdsm_vignette.Rnw:945-946
###################################################
bma_results2[[16]]


###################################################
### code chunk number 33: bdsm_vignette.Rnw:952-953
###################################################
size_graphs2 <- model_sizes(bma_results2)


###################################################
### code chunk number 34: bdsm_vignette.Rnw:960-961
###################################################
model_graphs2 <- model_pmp(bma_results2)


###################################################
### code chunk number 35: bdsm_vignette.Rnw:968-969
###################################################
bma_results2[[1]]


###################################################
### code chunk number 36: bdsm_vignette.Rnw:977-978
###################################################
bma_results2[[2]]


###################################################
### code chunk number 37: bdsm_vignette.Rnw:986-987
###################################################
jointness(bma_results2, measure = "HCGHM", rho = 0.5, round = 3)


###################################################
### code chunk number 38: bdsm_vignette.Rnw:994-996
###################################################
bma_results8 <- bma(full_model_space, df = data_prepared, round = 3, EMS = 8)
bma_results8[[16]]


###################################################
### code chunk number 39: bdsm_vignette.Rnw:1001-1002
###################################################
size_graphs8 <- model_sizes(bma_results8)


###################################################
### code chunk number 40: bdsm_vignette.Rnw:1008-1009
###################################################
model_graphs8 <- model_pmp(bma_results8)


###################################################
### code chunk number 41: bdsm_vignette.Rnw:1015-1016
###################################################
bma_results8[[1]]


###################################################
### code chunk number 42: bdsm_vignette.Rnw:1023-1024
###################################################
bma_results8[[2]]


###################################################
### code chunk number 43: bdsm_vignette.Rnw:1032-1033
###################################################
jointness(bma_results8, measure = "HCGHM", rho = 0.5, round = 3)


###################################################
### code chunk number 44: bdsm_vignette.Rnw:1049-1055
###################################################
bma_results_dil <- bma(
  model_space = full_model_space,
  df          = data_prepared,
  round       = 3,
  dilution    = 1
  )


###################################################
### code chunk number 45: bdsm_vignette.Rnw:1060-1061
###################################################
size_graphs_dil <- model_sizes(bma_results_dil)


###################################################
### code chunk number 46: bdsm_vignette.Rnw:1069-1077
###################################################
bma_results_dil01 <- bma(
  model_space = full_model_space,
  df          = data_prepared,
  round       = 3,
  dilution    = 1,
  dil.Par     = 0.1
)
size_graphs_dil01 <- model_sizes(bma_results_dil01)


###################################################
### code chunk number 47: bdsm_vignette.Rnw:1082-1090
###################################################
bma_results_dil2 <- bma(
  model_space = full_model_space,
  df          = data_prepared,
  round       = 3,
  dilution    = 1,
  dil.Par     = 2
)
size_graphs_dil2 <- model_sizes(bma_results_dil2)


###################################################
### code chunk number 48: bdsm_vignette.Rnw:1097-1098
###################################################
bma_results_dil2[[2]]


