test_that("envirotox-25-acute", {
  chk::check_key(envirotox::envirotox_25_acute, c("Chemical", "Species"))
  
  expect_snapshot_data(envirotox_25_acute, "envirotox_25_acute")
})
