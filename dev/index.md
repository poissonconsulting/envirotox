# envirotox

The `envirotox` R data package provides Species Sensitivity Distribution
(SSD) datasets from the [Envirotox
database](http://www.envirotoxdatabase.org/) 2.0.0 (Connors et
al. 2019).

The datasets are provided for assessing general patterns in SSD data and
testing code. The datasets should not be used to draw any conclusions
about the toxicity of the individual chemicals.

The package provides three data frames: `envirotox_acute` and
`envirotox_chronic`, which give the species concentrations for acute and
chronic toxicity tests, respectively, and `envirotox_chemical`, which
maps each chemical name to its original Chemical Abstracts Service (CAS)
registry number. Use
[`list_datasets()`](https://poissonconsulting.github.io/envirotox/dev/reference/list_datasets.md)
to list the available datasets. In `envirotox_acute` and
`envirotox_chronic` each chemical (the `Chemical` column) constitutes a
separate SSD dataset, with one row per species (`Species`) giving the
geometric mean concentration (`Conc`, in micrograms per litre) and
taxonomic group (`Group`).

The data is aggregated based on the
[code](https://github.com/miinay/SSD_distribution_comparison/blob/main/Rcode.R)
provided by Yanagihara et al. (2024) with three exceptions: the
`envirotox` package also includes chemical datasets with 1) a bimodality
coefficient \> 0.555, 2) between six and nine species; and 3) two
groups.

A logical column called `Yanagihara24` indicates which chemical datasets
are consistent with the criteria used by Yanagihara et al. (2024), which
required a bimodality coefficient \<= 0.555, at least 10 species and
three groups. A second logical column called `Iwasaki25` in
`envirotox_acute` indicates the chemical datasets included by Iwasaki et
al. (2025).

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

Iwasaki, Y., and Yanagihara, M. 2025. Comparison of model-averaging and
single-distribution approaches to estimating species sensitivity
distributions and hazardous concentrations for 5% of species.
Environmental Toxicology and Chemistry 44(3): 834–840.
<doi:10.1093/etojnl/vgae060>.

Yanagihara, M., Hiki, K., and Iwasaki, Y. 2024. Which distribution to
choose for deriving a species sensitivity distribution? Implications
from analysis of acute and chronic ecotoxicity data. Ecotoxicology and
environmental safety 278: 116379. <doi:10.1016/j.ecoenv.2024.116379>.
