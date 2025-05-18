test_that("envirotox-chronic", {
  chk::check_key(envirotox::envirotox_chronic, c("Chemical", "Species"))
  
  expect_snapshot_data(envirotox_chronic, "envirotox_chronic")
})
