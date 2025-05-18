
<!-- README.md is generated from README.Rmd. Please edit that file -->

# envirotox

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/poissonconsulting/envirotox/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/envirotox/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The envirotox R data package makes Species Sensitivity Distribution
(SSD) datasets from the [Envirotox
database](http://www.envirotoxdatabase.org/) available for testing cod

The datasets should not be used to make any conclusions about the
toxicity of the chemicals in the database.

## Installation

To install the most recent version from
[GitHub](https://github.com/poissonconsulting/flobr)

``` r
# install.packages("remotes")
remotes::install_github("poissonconsulting/flobr")
```

## Demonstration

``` r
library(envirotox)
library(ssdtools)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(tidyr)

data <- envirotox::yanagihara_24_acute

data |>
  count(Chemical) |>
  pull(n) |>
  summary() |>
  print()
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>    6.00    7.00   11.00   20.51   19.00  396.00

data <- data |>
  dplyr::nest_by(Chemical) |>
  dplyr::mutate(n = nrow(data), 
                ssd_fit = list(ssd_fit_dists(data, silent = TRUE)),
                ssd_hc = list(ssd_hc(ssd_fit, average = FALSE))) |>
  tidyr::unnest(ssd_hc) |>
  print()
#> # A tibble: 3,475 × 15
#> # Groups:   Chemical [729]
#>    Chemical     data     n ssd_fit    dist  proportion     est    se   lcl   ucl
#>    <chr>     <list<> <int> <list>     <chr>      <dbl>   <dbl> <dbl> <dbl> <dbl>
#>  1 (+/-)-ci… [6 × 9]     6 <fitdists> gamma       0.05   0.435    NA    NA    NA
#>  2 (+/-)-ci… [6 × 9]     6 <fitdists> lgum…       0.05   0.490    NA    NA    NA
#>  3 (+/-)-ci… [6 × 9]     6 <fitdists> llog…       0.05   0.765    NA    NA    NA
#>  4 (+/-)-ci… [6 × 9]     6 <fitdists> lnorm       0.05   0.588    NA    NA    NA
#>  5 (+/-)-ci… [6 × 9]     6 <fitdists> weib…       0.05   0.499    NA    NA    NA
#>  6 (2R,6S)-… [6 × 9]     6 <fitdists> gamma       0.05 208.       NA    NA    NA
#>  7 (2R,6S)-… [6 × 9]     6 <fitdists> lgum…       0.05 255.       NA    NA    NA
#>  8 (2R,6S)-… [6 × 9]     6 <fitdists> llog…       0.05 235.       NA    NA    NA
#>  9 (2R,6S)-… [6 × 9]     6 <fitdists> lnorm       0.05 243.       NA    NA    NA
#> 10 (2R,6S)-… [6 × 9]     6 <fitdists> weib…       0.05 226.       NA    NA    NA
#> # ℹ 3,465 more rows
#> # ℹ 5 more variables: wt <dbl>, method <chr>, nboot <int>, pboot <dbl>,
#> #   samples <I<list>>

data |>
  dplyr::group_by(Chemical) |>
  dplyr::arrange(desc(wt)) |>
  dplyr::slice(1) |>
  dplyr::ungroup() |>
  dplyr::count(dist) |>
  dplyr::arrange(desc(n)) |>
  print()
#> # A tibble: 6 × 2
#>   dist            n
#>   <chr>       <int>
#> 1 weibull       177
#> 2 lgumbel       161
#> 3 gamma         149
#> 4 lnorm         115
#> 5 lnorm_lnorm    89
#> 6 llogis         38

data |>
  dplyr::group_by(dist) |>
  dplyr::summarise(wt = mean(wt), .groups = "drop") |>
  dplyr::arrange(desc(wt)) |>
  print()
#> # A tibble: 6 × 2
#>   dist           wt
#>   <chr>       <dbl>
#> 1 lnorm_lnorm 0.287
#> 2 gamma       0.236
#> 3 weibull     0.230
#> 4 lgumbel     0.202
#> 5 lnorm       0.186
#> 6 llogis      0.162
```
