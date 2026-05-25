# Envirotox Chemical Data

Envirotox Chemical Data

## Usage

``` r
envirotox_chemical
```

## Format

### `envirotox_chemical`

A data frame with 744 rows and 2 columns:

- Chemical:

  Chemical name (chr)

- OriginalCAS:

  Original Chemical Abstracts Service Registry Number (int)

## Source

<https://envirotoxdatabase.org/>

## Examples

``` r

head(envirotox_chemical)
#> # A tibble: 6 × 2
#>   Chemical                  OriginalCAS
#>   <chr>                           <int>
#> 1 (+/-)-cis-Permethrin         61949766
#> 2 (2R,6S)-Fenpropimorph        67564914
#> 3 1,1,1-Trichloroethane           71556
#> 4 1,1,2,2-Tetrachloroethane       79345
#> 5 1,1,2-Trichloroethane           79005
#> 6 1,1-Dichloroethylene            75354
```
