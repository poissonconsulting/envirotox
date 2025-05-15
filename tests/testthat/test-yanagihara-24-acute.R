test_that("yanagihara-24-acute", {
  chk::check_key(envirotox::yanagihara_24_acute, c("Chemical", "Species"))
  
  expect_snapshot_data(yanagihara_24_acute, "yanagihara_24_acute")
})
