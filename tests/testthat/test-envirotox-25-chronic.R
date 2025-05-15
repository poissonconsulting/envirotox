test_that("envirotox-25-chronic", {
  chk::check_key(envirotox::envirotox_25_chronic, c("Chemical", "Species"))
  
  expect_snapshot_data(envirotox_25_chronic, "envirotox_25_acute")
})
