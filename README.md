## Benchmarking methods for identification of spatially variable genes

Spatially resolved transcriptomics enables the profiling of gene expression in cells while maintaining their spatial context, thereby introducing a new dimension to the data. An essential step in analyzing such data involves identifying genes that exhibit varying expression patterns across space. A variety of computational methods have been developed with diverse strategies and assumptions to accomplish this task. However, the absence of a benchmark on the performance of these methods hinders their effective use. We here present a systematic evaluation of 13 methods on XXX simulated and XXX real-world spatial transcriptomics datasets generated by imaging-based or sequencing-based technologies.


We aim to address following question

* Are the methods robust to different spatial patterns?
* Which method have the best performance?
* When applied to real data, do they give consistent results?
* How is scalibility and usability of each method?

### Methods

| Name      | Model                      | Language | Data       | Publication     | Year  |
| ---       | ---                        | ---      | ---        | -----------     |-------|
| Moran’s I | Spatial Autocorrelation    | Python   | Normalized |  [Biometrika](https://academic.oup.com/biomet/article/37/1-2/17/194868) |  1950 |
| SpatialDE | Gaussian process regression| Python   | Normalized |  [Nature Methods](https://www.nature.com/articles/nmeth.4636) |  2018 |
| Trendsceek   | Marked point processes | R   | Normalized |  [Nature Methods](https://www.nature.com/articles/nmeth.4634) |  2018 |
| SPARK     | Generalized spatial linear models | R   | Count |  [Nature Methods](https://www.nature.com/articles/s41592-019-0701-7) |  2020 |
| SPARK-X   | Non-parametric spatial modeling | R   | Count |  [Genome Biology](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02404-0) |  2021 |
| SpaGCN   | Graph convolutional network | Python   | Normalized |  [Nature Methods](https://www.nature.com/articles/s41592-021-01255-8) |  2021 |
| SOMDE   | Self-organizing map | Python   | Normalized |  [Bioinformatics](https://academic.oup.com/bioinformatics/article/37/23/4392/6308937) |  2021 |
| BOOST-GP   | Bayesian hierarchical model | R   | Count |  [Bioinformatics](https://academic.oup.com/bioinformatics/article/37/22/4129/6306406) |  2021 |
| SpatialDE2 | Poisson Hidden Markov Random field | Python   | Count |  [bioRxiv](https://www.biorxiv.org/content/10.1101/2021.10.27.466045v2) |  2021 |
| sepal   | diffusion model | Python   | Count | [Bioinformatics](https://academic.oup.com/bioinformatics/article/37/17/2644/6168120?login=false) |  2021 |
| GPcounts   | Gaussian process regression | Python   | Count | [Bioinformatics](https://academic.oup.com/bioinformatics/article/37/21/3788/6313161) |  2022 |
| CTSV   | Zero-inflated negative binomial regression | R   | Count |  [Bioinformatics](https://academic.oup.com/bioinformatics/article/38/17/4135/6632658) |  2022 |
| scGCO   | Hidden Markov Random Fields | Python   | Count | [Nature communications](https://www.nature.com/articles/s41467-022-33182-3) |  2022 |
| nnSVG   | nearest-neighbor Gaussian processes | R   | Count | [bioRxiv](https://www.biorxiv.org/content/10.1101/2022.05.16.492124v1.full) |  2022 |
