
<!-- README.md is generated from README.Rmd. Please edit that file -->

# envirotox

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of the envirotox R data package is to make alternative datasets
from the [Envirotox database](http://www.envirotoxdatabase.org/)
available for testing species sensitivity distribution code.

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
#>    10.0    11.0    14.0    21.1    24.0    97.0

data <- data |>
  dplyr::nest_by(Chemical) |>
  dplyr::mutate(n = nrow(data), 
                ssd_fit = list(ssd_fit_dists(data, silent = TRUE)),
                ssd_hc = list(ssd_hc(ssd_fit, average = FALSE))) |>
  tidyr::unnest(ssd_hc) |>
  print()
#> # A tibble: 512 × 15
#> # Groups:   Chemical [103]
#>    Chemical      data     n ssd_fit    dist  proportion    est    se   lcl   ucl
#>    <chr>     <list<t> <int> <list>     <chr>      <dbl>  <dbl> <dbl> <dbl> <dbl>
#>  1 1,1,2-Tr… [10 × 5]    10 <fitdists> gamma       0.05 32778.    NA    NA    NA
#>  2 1,1,2-Tr… [10 × 5]    10 <fitdists> lgum…       0.05 42924.    NA    NA    NA
#>  3 1,1,2-Tr… [10 × 5]    10 <fitdists> llog…       0.05 33975.    NA    NA    NA
#>  4 1,1,2-Tr… [10 × 5]    10 <fitdists> lnorm       0.05 37884.    NA    NA    NA
#>  5 1,1,2-Tr… [10 × 5]    10 <fitdists> weib…       0.05 25834.    NA    NA    NA
#>  6 1,2,4-Tr… [14 × 5]    14 <fitdists> gamma       0.05   402.    NA    NA    NA
#>  7 1,2,4-Tr… [14 × 5]    14 <fitdists> lgum…       0.05   802.    NA    NA    NA
#>  8 1,2,4-Tr… [14 × 5]    14 <fitdists> llog…       0.05   634.    NA    NA    NA
#>  9 1,2,4-Tr… [14 × 5]    14 <fitdists> lnorm       0.05   666.    NA    NA    NA
#> 10 1,2,4-Tr… [14 × 5]    14 <fitdists> weib…       0.05   276.    NA    NA    NA
#> # ℹ 502 more rows
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
#> 1 lnorm          23
#> 2 lgumbel        19
#> 3 gamma          18
#> 4 weibull        18
#> 5 llogis         13
#> 6 lnorm_lnorm    12

data |>
  dplyr::group_by(dist) |>
  dplyr::summarise(wt = mean(wt), .groups = "drop") |>
  dplyr::arrange(desc(wt)) |>
  print()
#> # A tibble: 6 × 2
#>   dist           wt
#>   <chr>       <dbl>
#> 1 lnorm       0.219
#> 2 gamma       0.212
#> 3 weibull     0.211
#> 4 llogis      0.202
#> 5 lnorm_lnorm 0.178
#> 6 lgumbel     0.174
```
