# Acute Species Sensitivity Datasets

Acute Species Sensitivity Datasets

## Usage

``` r
envirotox_acute
```

## Format

### `envirotox_acute`

A data frame with 14,949 rows and 6 columns:

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

- Iwasaki25:

  Whether the dataset was included in Iwasaki et al. (2025) (flag).

## Source

<https://envirotoxdatabase.org/>

## References

Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to
choose for deriving a species sensitivity distribution? Implications
from analysis of acute and chronic ecotoxicity data. Ecotoxicology and
environmental safety 278: 116379. doi:10.1016/j.ecoenv.2024.116379.

Iwasaki, Y., and Yanagihara, M. 2025. Comparison of model-averaging and
single-distribution approaches to estimating species sensitivity
distributions and hazardous concentrations for 5% of species.
Environmental Toxicology and Chemistry 44(3): 834–840.
doi:10.1093/etojnl/vgae060.

## Examples

``` r
head(envirotox_acute)
#> # A tibble: 6 × 6
#>   Chemical              Conc Species                Group Yanagihara24 Iwasaki25
#>   <chr>                <dbl> <chr>                  <chr> <lgl>        <lgl>    
#> 1 (+/-)-cis-Permethrin  0.36 Culex quinquefasciatus Inve… FALSE        FALSE    
#> 2 (+/-)-cis-Permethrin  5    Cyprinodon macularius  Fish  FALSE        FALSE    
#> 3 (+/-)-cis-Permethrin 13    Gambusia affinis       Fish  FALSE        FALSE    
#> 4 (+/-)-cis-Permethrin 13.2  Oncorhynchus mykiss    Fish  FALSE        FALSE    
#> 5 (+/-)-cis-Permethrin  5.6  Oreochromis mossambic… Fish  FALSE        FALSE    
#> 6 (+/-)-cis-Permethrin 38    Oryzias latipes        Fish  FALSE        FALSE    
```
