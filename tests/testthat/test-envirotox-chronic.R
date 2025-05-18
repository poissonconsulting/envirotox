test_that("envirotox-chronic", {
  chk::check_key(envirotox_chronic, c("Chemical", "Species"))
  expect_identical(nrow(envirotox_chronic), 1721L)
  expect_snapshot_data(envirotox_chronic, "envirotox_chronic")
})
