## Benchmarking methods for identification of spatially variable genes

Spatially resolved transcriptomics enables the profiling of gene expression in cells while maintaining their spatial context, thereby introducing a new dimension to the data. A crucial aspect of analyzing this type of data involves identifying genes that vary in expression across space. To achieve this, various methods have been devised with different computational strategies.

### Methods

| Name      | Model                      | Language | Data       | Publication     | Year  |
| ---       | ---                        | ---      | ---        | -----------     |-------|
| Moran’s I | Spatial Autocorrelation    | Python   | Normalized |  Biometrika |  1950 |
| SpatialDE | Gaussian process regression| Python   | Normalized |  Nature Methods |  2018 |
| Trendsceek   | Marked point processes | R   | Normalized |  Nature Methods |  2018 |
| SPARK     | Generalized spatial linear models | R   | Count |  Nature Methods |  2020 |
| SPARK-X   | Non-parametric spatial modeling | R   | Count |  Genome Biology |  2021 |
| SpaGCN   | Graph convolutional network | Python   | Normalized |  Nature Methods |  2021 |
| SOMDE   | Self-organizing map | Python   | Normalized |  Bioinformatics |  2021 |
| BOOST-GP   | Bayesian hierarchical model | R   | Count |  Bioinformatics |  2021 |
| SpatialDE2 | Poisson Hidden Markov Random field | Python   | Count |  bioRxiv |  2021 |
| GPcounts   | Gaussian process regression | Python   | Count | Bioinformatics |  2022 |
| sepal   | diffusion model | Python   | Count | Bioinformatics |  2021 |
| CTSV   | Zero-inflated negative binomial regression | R   | Count |  Bioinformatics |  2022 |
| scGCO   | Hidden Markov Random Fields | Python   | Count | Nature communications |  2022 |
