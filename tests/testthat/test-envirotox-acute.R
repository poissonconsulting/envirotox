test_that("envirotox-acute", {
  chk::check_key(envirotox::envirotox_acute, c("Chemical", "Species"))
  expect_identical(nrow(envirotox_acute), 14949L)
  expect_snapshot_data(envirotox_acute, "envirotox_acute")
})
