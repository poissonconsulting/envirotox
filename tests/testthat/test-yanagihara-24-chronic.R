test_that("yanagihara-24-chronic", {
  chk::check_key(envirotox::yanagihara_24_chronic, c("Chemical", "Species"))
  
  expect_snapshot_data(yanagihara_24_chronic, "yanagihara_24_chronic")
})
