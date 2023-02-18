## Benchmarking methods for identification of spatially variable genes

Spatially resolved transcriptomics enables the profiling of gene expression in cells while maintaining their spatial context, thereby introducing a new dimension to the data. An essential step in analyzing such data involves identifying genes that exhibit varying expression patterns across space. Several computational methods have been developed with diverse strategies and assumptions to accomplish this task. However, the absence of a benchmark on the performance of these methods hinders their effective use. We here present a systematic evaluation of in total 13 methods on XXX datasets from XXX technologies.

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
| sepal   | diffusion model | Python   | Count | Bioinformatics |  2021 |
| GPcounts   | Gaussian process regression | Python   | Count | Bioinformatics |  2022 |
| CTSV   | Zero-inflated negative binomial regression | R   | Count |  Bioinformatics |  2022 |
| scGCO   | Hidden Markov Random Fields | Python   | Count | Nature communications |  2022 |
