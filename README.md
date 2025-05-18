
<!-- README.md is generated from README.Rmd. Please edit that file -->

# envirotox

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/poissonconsulting/envirotox/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/poissonconsulting/envirotox/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The `envirotox` R data package provides Species Sensitivity Distribution
(SSD) datasets from the [Envirotox
database](http://www.envirotoxdatabase.org/) (Connors et al. 2019).

The datasets are provided for assessing general patterns in SSD data and
testing code. The datasets should not be used to draw any conclusions
about the toxicity of the individual chemicals.

The package provides datasets of acute (`envirotox_acute`) and chronic
(`envirotox_chronic`) tests and a reference dataset with the Original
CAS numbers (`envirotox_chemical`).

The data is aggregated based on the
[code](https://github.com/miinay/SSD_distribution_comparison/blob/main/Rcode.R)
provided by Yanagihara et al. (2024) with three exceptions: the datasets
in the `envirotox` package also include datasets with 1) a binomial
coefficient \> 0.555, 2) between six and nine species; and 3) two
groups. A logical vector called `Yanagihara_2024` indicates which
datasets are consistent with the criteria used by Yanagihara et
al. (2024) which required a binomial coefficient $<=$ 0.555, at least 10
species and three groups.

## Installation

To install the most recent version from
[GitHub](https://github.com/poissonconsulting/envirotox)

``` r
# install.packages("pak")
pak::pak("poissonconsulting/envirotox")
```

## References

Connors, K.A., Beasley, A., Barron, M.G., Belanger, S.E., Bonnell, M.,
Brill, J.L., de Zwart, D., Kienzler, A., Krailler, J., Otter, R.,
Phillips, J.L., and Embry, M.R. 2019. Creation of a Curated Aquatic
Toxicology Database: EnviroTox. Enviro Toxic and Chemistry 38(5):
1062–1073. <doi:10.1002/etc.4382>.

Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to
choose for deriving a species sensitivity distribution? Implications
from analysis of acute and chronic ecotoxicity data. Ecotoxicology and
environmental safety 278: 116379. <doi:10.1016/j.ecoenv.2024.116379>.
