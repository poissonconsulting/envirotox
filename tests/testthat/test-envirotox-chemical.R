test_that("envirotox-chemical", {
  chk::check_key(envirotox_chemical, "Chemical")
  chk::check_key(envirotox_chemical, "OriginalCAS")
  expect_identical(nrow(envirotox_chemical), 744L)
  expect_snapshot_data(envirotox_chemical, "envirotox_chemical")
})
