
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

or from [r-universe](https://poissonconsulting.r-universe.dev/flobr).

``` r
install.packages("flobr", repos = c("https://poissonconsulting.r-universe.dev", "https://cloud.r-project.org"))
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

data <- envirotox::yanagihara_24_chronic |>
  dplyr::nest_by(Chemical) %>%
  dplyr::mutate(ssd_fit = list(ssd_fit_dists(data, silent = TRUE)),
                ssd_hc = list(ssd_hc(ssd_fit, average = FALSE))) %>%
  tidyr::unnest(ssd_hc)

print(data)
#> # A tibble: 46 × 14
#> # Groups:   Chemical [9]
#>    Chemical     data ssd_fit    dist  proportion     est    se   lcl   ucl    wt
#>    <chr>    <list<t> <list>     <chr>      <dbl>   <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1 2,4-Dic… [10 × 5] <fitdists> gamma       0.05 2.23e+1    NA    NA    NA 0.327
#>  2 2,4-Dic… [10 × 5] <fitdists> lgum…       0.05 1.37e+2    NA    NA    NA 0.109
#>  3 2,4-Dic… [10 × 5] <fitdists> llog…       0.05 7.19e+1    NA    NA    NA 0.112
#>  4 2,4-Dic… [10 × 5] <fitdists> lnorm       0.05 1.04e+2    NA    NA    NA 0.195
#>  5 2,4-Dic… [10 × 5] <fitdists> weib…       0.05 4.81e+1    NA    NA    NA 0.256
#>  6 3,4-Dic… [11 × 5] <fitdists> gamma       0.05 1.69e-2    NA    NA    NA 0.161
#>  7 3,4-Dic… [11 × 5] <fitdists> lgum…       0.05 2.59e-1    NA    NA    NA 0.107
#>  8 3,4-Dic… [11 × 5] <fitdists> llog…       0.05 1.84e-1    NA    NA    NA 0.220
#>  9 3,4-Dic… [11 × 5] <fitdists> lnorm       0.05 2.32e-1    NA    NA    NA 0.283
#> 10 3,4-Dic… [11 × 5] <fitdists> weib…       0.05 5.65e-2    NA    NA    NA 0.229
#> # ℹ 36 more rows
#> # ℹ 4 more variables: method <chr>, nboot <int>, pboot <dbl>, samples <I<list>>

data |>
  dplyr::group_by(dist) %>%
  dplyr::summarise(wt = mean(wt), .groups = "drop") %>%
  dplyr::arrange(desc(wt))
#> # A tibble: 6 × 2
#>   dist            wt
#>   <chr>        <dbl>
#> 1 lnorm       0.257 
#> 2 llogis      0.233 
#> 3 lgumbel     0.225 
#> 4 weibull     0.152 
#> 5 gamma       0.148 
#> 6 lnorm_lnorm 0.0540
```
