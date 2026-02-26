# Chronic Species Sensitivity Datasets

Chronic Species Sensitivity Datasets

## Usage

``` r
envirotox_chronic
```

## Format

### `envirotox_chronic`

A data frame with 1,721 rows and 6 columns:

- Chemical:

  Chemical name (chr)

- Conc:

  Concentration of chemical in micrograms per litre (dbl).

- Species:

  Species name (chr).

- Group:

  Taxonomic group of species (chr).

- Yanagihara24:

  Whether the dataset fits the criteria of Yanagihara et al. (2024)
  (flag).

## Source

<https://envirotoxdatabase.org/>

## References

Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to
choose for deriving a species sensitivity distribution? Implications
from analysis of acute and chronic ecotoxicity data. Ecotoxicology and
environmental safety 278: 116379. doi:10.1016/j.ecoenv.2024.116379.

## Examples

``` r
head(envirotox_chronic)
#> # A tibble: 6 × 5
#>   Chemical                 Conc Species                  Group      Yanagihara24
#>   <chr>                   <dbl> <chr>                    <chr>      <lgl>       
#> 1 1,2,4-Trichlorobenzene   85.4 Americamysis bahia       Invertebr… FALSE       
#> 2 1,2,4-Trichlorobenzene  264.  Daphnia magna            Invertebr… FALSE       
#> 3 1,2,4-Trichlorobenzene  410.  Oncorhynchus mykiss      Fish       FALSE       
#> 4 1,2,4-Trichlorobenzene  260   Oryzias latipes          Fish       FALSE       
#> 5 1,2,4-Trichlorobenzene  417.  Pimephales promelas      Fish       FALSE       
#> 6 1,2,4-Trichlorobenzene 1483.  Raphidocelis subcapitata Algae      FALSE       
```
