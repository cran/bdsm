test_that("feature_standardization returns data frame for not cross sectional", {
  set.seed(1)
  df <- generate_test_feature_standard_data()
  expect_s3_class(df, "data.frame")
})

test_that("feature_standardization returns tibble for cross-sectional demeaning (time effects)", {
  set.seed(1)
  df <- generate_test_feature_standard_data(time_effects = TRUE)
  expect_s3_class(df, "tbl")
})

test_that("feature_standardization returns all columns provided", {
  set.seed(1)
  df <- generate_test_feature_standard_data()
  expect_equal(length(df), length(generate_test_data()))
  expect_equal(colnames(df), colnames(generate_test_data()))
})

test_that("feature_standardization returns all rows provided", {
  set.seed(1)
  df <- generate_test_feature_standard_data()
  expect_equal(nrow(df), nrow(generate_test_data()))
})

test_that("data_prep returns all rows provided", {
  set.seed(1)
  df <- generate_test_data_prep_data()
  expect_equal(nrow(df), nrow(generate_test_data()))
})

test_that("data_prep returns all columns provided", {
  set.seed(1)
  df <- generate_test_data_prep_data()
  expect_equal(length(df), length(generate_test_data()))
  expect_equal(colnames(df), colnames(generate_test_data()))
})
