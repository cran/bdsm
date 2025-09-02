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
### code chunk number 2: bdsm_vignette.Rnw:415-416 (eval = FALSE)
###################################################
## install.packages("bdsm")


###################################################
### code chunk number 3: bdsm_vignette.Rnw:419-420
###################################################
library(bdsm)


###################################################
### code chunk number 4: bdsm_vignette.Rnw:429-430
###################################################
economic_growth[1:12,1:10]


###################################################
### code chunk number 5: bdsm_vignette.Rnw:435-436
###################################################
original_economic_growth[1:12,1:10]


###################################################
### code chunk number 6: bdsm_vignette.Rnw:450-458
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
### code chunk number 7: bdsm_vignette.Rnw:475-479
###################################################
data_standardized_features <- feature_standardization(
    df            = economic_growth,
    excluded_cols = c(country, year, gdp)
  )


###################################################
### code chunk number 8: bdsm_vignette.Rnw:484-490
###################################################
data_prepared <- feature_standardization(
    df            = data_standardized_features,
    group_by_col  = year,
    excluded_cols = country,
    scale         = FALSE
  )


###################################################
### code chunk number 9: bdsm_vignette.Rnw:511-518 (eval = FALSE)
###################################################
## full_model_space <- optim_model_space(
##   df            = data_prepared,
##   dep_var_col   = gdp,
##   timestamp_col = year,
##   entity_col    = country,
##   init_value    = 0.5
## )


###################################################
### code chunk number 10: bdsm_vignette.Rnw:539-540
###################################################
full_model_space$params[1:10, 1:5]


###################################################
### code chunk number 11: bdsm_vignette.Rnw:556-557
###################################################
full_model_space$stats[, 1:5]


###################################################
### code chunk number 12: bdsm_vignette.Rnw:650-657 (eval = FALSE)
###################################################
## model_space <- optim_model_space(
##   df            = data_prepared,
##   dep_var_col   = gdp,
##   timestamp_col = year,
##   entity_col    = country,
##   init_value    = 0.5
## )


###################################################
### code chunk number 13: bdsm_vignette.Rnw:666-672 (eval = FALSE)
###################################################
## library(parallel)
## # Here we try to use all available cores on the system.
## # You might want to lower the number of cores depending on your needs.
## cores <- detectCores()
## cl <- makeCluster(cores)
## setDefaultCluster(cl)


###################################################
### code chunk number 14: bdsm_vignette.Rnw:677-685 (eval = FALSE)
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
### code chunk number 15: bdsm_vignette.Rnw:713-714
###################################################
bma_results <- bma(full_model_space, df = data_prepared, round = 3)


###################################################
### code chunk number 16: bdsm_vignette.Rnw:722-723
###################################################
bma_results[[1]]


###################################################
### code chunk number 17: bdsm_vignette.Rnw:744-745
###################################################
bma_results[[2]]


###################################################
### code chunk number 18: bdsm_vignette.Rnw:759-760
###################################################
bma_results[[16]]


###################################################
### code chunk number 19: bdsm_vignette.Rnw:779-780
###################################################
for_models <- model_pmp(bma_results)


###################################################
### code chunk number 20: bdsm_vignette.Rnw:786-787
###################################################
for_models <- model_pmp(bma_results, top = 10)


###################################################
### code chunk number 21: bdsm_vignette.Rnw:806-807
###################################################
size_graphs <- model_sizes(bma_results)


###################################################
### code chunk number 22: bdsm_vignette.Rnw:835-837
###################################################
best_8_models <- best_models(bma_results, criterion = 1, best = 8)
best_8_models[[1]]


###################################################
### code chunk number 23: bdsm_vignette.Rnw:843-845
###################################################
best_3_models <- best_models(bma_results, criterion = 2, best = 3)
best_3_models[[5]]


###################################################
### code chunk number 24: bdsm_vignette.Rnw:854-856
###################################################
best_3_models <- best_models(bma_results, criterion = 2, best = 3)
best_3_models[[9]]


###################################################
### code chunk number 25: bdsm_vignette.Rnw:869-870
###################################################
jointness(bma_results)


###################################################
### code chunk number 26: bdsm_vignette.Rnw:880-881
###################################################
jointness(bma_results, measure = "LS")


###################################################
### code chunk number 27: bdsm_vignette.Rnw:889-890
###################################################
jointness(bma_results, measure = "DW")


###################################################
### code chunk number 28: bdsm_vignette.Rnw:908-910
###################################################
coef_plots <- coef_hist(bma_results)
coef_plots[[1]]


###################################################
### code chunk number 29: bdsm_vignette.Rnw:914-916
###################################################
coef_plots2 <- coef_hist(bma_results, kernel = 1)
coef_plots2[[1]]


###################################################
### code chunk number 30: bdsm_vignette.Rnw:920-923
###################################################
library(gridExtra)
grid.arrange(coef_plots[[1]], coef_plots[[2]], coef_plots2[[1]],
             coef_plots2[[2]], nrow = 2, ncol = 2)


###################################################
### code chunk number 31: bdsm_vignette.Rnw:941-942
###################################################
bma_results2 <- bma(full_model_space, df = data_prepared, round = 3, EMS = 2)


###################################################
### code chunk number 32: bdsm_vignette.Rnw:947-948
###################################################
bma_results2[[16]]


###################################################
### code chunk number 33: bdsm_vignette.Rnw:954-955
###################################################
size_graphs2 <- model_sizes(bma_results2)


###################################################
### code chunk number 34: bdsm_vignette.Rnw:962-963
###################################################
model_graphs2 <- model_pmp(bma_results2)


###################################################
### code chunk number 35: bdsm_vignette.Rnw:970-971
###################################################
bma_results2[[1]]


###################################################
### code chunk number 36: bdsm_vignette.Rnw:979-980
###################################################
bma_results2[[2]]


###################################################
### code chunk number 37: bdsm_vignette.Rnw:988-989
###################################################
jointness(bma_results2, measure = "HCGHM", rho = 0.5, round = 3)


###################################################
### code chunk number 38: bdsm_vignette.Rnw:996-998
###################################################
bma_results8 <- bma(full_model_space, df = data_prepared, round = 3, EMS = 8)
bma_results8[[16]]


###################################################
### code chunk number 39: bdsm_vignette.Rnw:1003-1004
###################################################
size_graphs8 <- model_sizes(bma_results8)


###################################################
### code chunk number 40: bdsm_vignette.Rnw:1010-1011
###################################################
model_graphs8 <- model_pmp(bma_results8)


###################################################
### code chunk number 41: bdsm_vignette.Rnw:1017-1018
###################################################
bma_results8[[1]]


###################################################
### code chunk number 42: bdsm_vignette.Rnw:1025-1026
###################################################
bma_results8[[2]]


###################################################
### code chunk number 43: bdsm_vignette.Rnw:1034-1035
###################################################
jointness(bma_results8, measure = "HCGHM", rho = 0.5, round = 3)


###################################################
### code chunk number 44: bdsm_vignette.Rnw:1051-1057
###################################################
bma_results_dil <- bma(
  model_space = full_model_space,
  df          = data_prepared,
  round       = 3,
  dilution    = 1
  )


###################################################
### code chunk number 45: bdsm_vignette.Rnw:1062-1063
###################################################
size_graphs_dil <- model_sizes(bma_results_dil)


###################################################
### code chunk number 46: bdsm_vignette.Rnw:1071-1079
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
### code chunk number 47: bdsm_vignette.Rnw:1084-1092
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
### code chunk number 48: bdsm_vignette.Rnw:1099-1100
###################################################
bma_results_dil2[[2]]


