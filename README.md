
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

data <- envirotox::yanagihara_24_acute |>
  dplyr::nest_by(Chemical) |>
  dplyr::mutate(ssd_fit = list(ssd_fit_dists(data, silent = TRUE)),
                ssd_hc = list(ssd_hc(ssd_fit, average = FALSE))) |>
  tidyr::unnest(ssd_hc)

print(data)
#> # A tibble: 512 × 14
#> # Groups:   Chemical [103]
#>    Chemical     data ssd_fit    dist  proportion    est    se   lcl   ucl     wt
#>    <chr>    <list<t> <list>     <chr>      <dbl>  <dbl> <dbl> <dbl> <dbl>  <dbl>
#>  1 1,1,2-T… [10 × 5] <fitdists> gamma       0.05 32778.    NA    NA    NA 0.186 
#>  2 1,1,2-T… [10 × 5] <fitdists> lgum…       0.05 42924.    NA    NA    NA 0.266 
#>  3 1,1,2-T… [10 × 5] <fitdists> llog…       0.05 33975.    NA    NA    NA 0.161 
#>  4 1,1,2-T… [10 × 5] <fitdists> lnorm       0.05 37884.    NA    NA    NA 0.253 
#>  5 1,1,2-T… [10 × 5] <fitdists> weib…       0.05 25834.    NA    NA    NA 0.134 
#>  6 1,2,4-T… [14 × 5] <fitdists> gamma       0.05   402.    NA    NA    NA 0.0597
#>  7 1,2,4-T… [14 × 5] <fitdists> lgum…       0.05   802.    NA    NA    NA 0.326 
#>  8 1,2,4-T… [14 × 5] <fitdists> llog…       0.05   634.    NA    NA    NA 0.270 
#>  9 1,2,4-T… [14 × 5] <fitdists> lnorm       0.05   666.    NA    NA    NA 0.298 
#> 10 1,2,4-T… [14 × 5] <fitdists> weib…       0.05   276.    NA    NA    NA 0.0471
#> # ℹ 502 more rows
#> # ℹ 4 more variables: method <chr>, nboot <int>, pboot <dbl>, samples <I<list>>

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
