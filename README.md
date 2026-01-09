# Benchmarking methods for identification of spatially variable genes

This repository contains comprehensive scripts and notebooks for benchmarking computational methods that identify spatially variable genes (SVGs) and peaks in spatial transcriptomics and spatial ATAC-seq data. The project provides a systematic evaluation framework across multiple spatial genomics technologies and datasets.

## Overview

Spatial transcriptomics technologies enable the measurement of gene expression while preserving spatial information, allowing researchers to study how gene expression varies across tissue locations. Identifying spatially variable genes is crucial for understanding tissue organization, development, and disease mechanisms. This benchmark evaluates various computational methods for SVG detection across different spatial genomics platforms including:

- **10x Visium**: High-throughput spatial gene expression profiling
- **Slide-seq v2**: High-resolution spatial transcriptomics 
- **DBiT-seq**: Deterministic barcoding in tissue for spatial omics sequencing
- **10x Xenium**: In situ spatial transcriptomics with subcellular resolution
- **MERFISH**: Multiplexed error-robust fluorescence in situ hybridization
- **seqFISH**: Sequential fluorescence in situ hybridization
- **Slide-tags**: Spatial transcriptomics using DNA-barcoded beads
- **Stereo-seq**: High-resolution spatial transcriptomics

## Repository Structure

### `prepare_reference_data/`
Notebooks for preprocessing and preparing reference datasets from various spatial transcriptomics studies. This includes data download, quality control, normalization, and formatting for downstream analysis. The processed data are used as reference for simulation. We here provided 50 notebooks that were used in our paper and it's possible to apply them to new datasets.

### `generate_simulate_data/`
Contains Jupyter notebooks for generating simulated spatial transcriptomics datasets based on real experimental data using [scDesign3](https://github.com/SONGDONGYUAN1994/scDesign3) package. Each notebook corresponds to a specific dataset and technology platform (e.g., 10x Visium mouse brain, human heart, various cancer tissues). The simulated data serves as ground truth for benchmarking SVG detection methods.

The simulated data are provided [here](https://zenodo.org/records/18193366) for downloading.

### `snakemake_simulate_data/`
Snakemake pipelines for large-scale benchmarking of SVG detection methods across simulated spatial transcriptomics datasets. This workflow systematically applies 14 different SVG detection methods to 50 diverse datasets from various spatial genomics technologies.

**Supported SVG Detection Methods:**
- **nnSVG**: Nearest-neighbor Gaussian process model
- **Spanve**: Spatial analysis of variance
- **SPARK-X**: Statistical test for spatial expression patterns
- **SPARK**: Spatial analysis of relative expression  
- **SpatialDE2**: Improved spatial differential expression
- **SpatialDE**: Spatial differential expression analysis
- **SOMDE**: Self-organizing map for spatial data
- **MoranI**: Moran's I spatial autocorrelation
- **scGCO**: Single-cell graph convolutional operator
- **SpaGCN**: Spatial graph convolutional networks
- **SpaGFT**: Spatial graph Fourier transform
- **GPcounts**: Gaussian process for count data
- **Sepal**: Spatial expression pattern analysis
- **BOOST-GP**: Bayesian optimization for spatial transcriptomics

**Usage:**

1. **Prerequisites**: Ensure you have Snakemake (≥6.4.1) and conda installed. 
   ```bash
   # Install Snakemake via conda/mamba
   conda install -c conda-forge -c bioconda snakemake
   # or
   pip install snakemake
   ```

2. **Download data**:
   To run the benchmarking, you need to either download or generate simulated data with ground truth as described above. 
   
   **Option A - Use pre-generated data:**
   - Download simulated datasets from the provided links in `generate_simulate_data/` section
   - Place `.h5ad` files in your input directory (e.g., `/your_path/01_generate_simulate_data/`)
   
   **Option B - Generate your own simulated data:**
   - Follow the notebooks in `generate_simulate_data/` to create simulated datasets
   - Ensure each dataset is saved as `.h5ad` format with spatial coordinates and ground truth labels

3. **Create conda environments**:
   Create dedicated conda environments for each benchmarked method to avoid dependency conflicts. 
   ```bash
   # Example for nnSVG (R-based method)
   conda create -n zl_nnSVG -c conda-forge -c bioconda r-base r-essentials
   conda activate zl_nnSVG
   # Install nnSVG and dependencies in R
   
   # Example for Python-based methods (Spanve, SOMDE, etc.)
   conda create -n zl_Spanve python=3.8 pandas numpy scipy scanpy
   conda activate zl_Spanve
   pip install spanve
   ```

   **Important**: Verify that you can successfully run the scripts under `snakemake_simulate_data/methods/` for each method before executing the complete pipeline.

4. **Configure paths**: 
   Edit the `Snakefile` to update output paths for your system:
   ```python
   # Update the output directory in the main rule
   rule all:
       input:
           expand("YOUR_OUTPUT_DIR/{method}/{dataset}.csv", method=method_list, dataset=dataset_list)
   ```

5. **Configure rules**:
   Edit the `.smk` rule files under `snakemake_simulate_data/rules/` to specify input data locations, script paths, conda environments, and output destinations for each method.
   
   **Example rule configuration (MoranI.smk):**
   ```python
   rule MoranI:
       input:
           "YOUR_INPUT_DIR/{dataset}.h5ad"  # Path to simulated data
       output:
           "YOUR_OUTPUT_DIR/MoranI/{dataset}.csv"  # Results destination
       conda:
           "zl_moranI"  # Conda environment name
       threads: 10
       benchmark:
           "YOUR_OUTPUT_DIR/benchmark/MoranI/{dataset}.txt"  # Runtime statistics
       shell:
           "python YOUR_SCRIPT_DIR/methods/run_MoranI.py -i {input} -o {output}"
   ```
   
   **Key parameters to update:**
   - `input`: Path to your simulated `.h5ad` files
   - `output`: Desired location for CSV results
   - `conda`: Name of the conda environment for this method
   - `benchmark`: Path for runtime/memory usage logs
   - `shell`: Full path to the method execution script

6. **Run the complete benchmark**:
   ```bash
   cd snakemake_simulate_data/
   # Dry run to check workflow
   snakemake -n
   
   # Run with specified cores
   snakemake -k --nolock --use-conda --cores 10 --rerun-triggers mtime --conda-base-path CONDA_DIR
   ```

   `CONDA_DIR`: Path of conda base installation


7. **Run specific methods or datasets**:
   ```bash
   # Run only specific methods (edit method_list and dataset_list in Snakefile first)
   snakemake -k --nolock --use-conda --cores <n_cores>
   ```

8. **Output Directory Structure**:
   After running the pipeline, you will find:
   - `methods/`: Python/R scripts for each SVG detection method
   - `rules/`: Snakemake rule files (.smk) defining workflow for each method
   - `output/`: Results directory containing CSV files with SVG detection results
   - `benchmark/`: Runtime and memory usage statistics for each method

**Adding New Methods:**
To add new SVG detection methods:
1. Create a Python or R script in `methods/` (e.g., `run_NewMethod.py`)
2. Add a corresponding Snakemake rule file in `rules/` (e.g., `NewMethod.smk`)
3. Include the new rule in the main `Snakefile`
4. Add the method name to `method_list` in `Snakefile` 

### `spatial_atac/`
Comprehensive analysis workflows for spatial ATAC-seq data, focusing on identifying spatially variable chromatin accessibility peaks (SVPs) across developmental time points. This section extends the SVG benchmarking framework to spatial chromatin accessibility analysis.

**Key Features:**
- **SVP Detection**: Application of 14 computational methods originally designed for SVG detection to spatial ATAC-seq data
- **Developmental Analysis**: Focus on mouse embryo development across multiple time points (E12.5, E13.5, E15.5)
- **Clustering Evaluation**: Comparison of clustering performance using all peaks vs. spatially variable peaks only
- **Statistical Assessment**: Integration scores (LISI) and clustering quality metrics (CHAOS) for method evaluation

**Workflow Components:**

1. **Peak Extraction** (`01_get_peaks.ipynb`):
   - Extract top spatially variable peaks from each method's output
   - Standardize peak ranking across different SVP detection approaches
   - Generate peak lists for downstream clustering analysis

2. **All Peaks Clustering** (`02_clustering_all_peaks.ipynb`):
   - Baseline clustering using all chromatin accessibility peaks
   - TF-IDF normalization and Latent Semantic Indexing (LSI) for dimensionality reduction
   - Leiden clustering and UMAP visualization

3. **SVP-based Clustering** (`03_clustering_svps.ipynb`):
   - Clustering analysis restricted to spatially variable peaks identified by each method
   - Performance comparison with all-peaks clustering
   - Method-specific clustering quality assessment

4. **Integration Analysis** (`04_LISI.ipynb`):
   - Local Inverse Simpson Index (LISI) calculation
   - Evaluation of how well spatial information is preserved in clustering

5. **Clustering Quality** (`05_CHAOS.ipynb`):
   - CHAOS (Clustering Heterogeneity Analysis of Spatial) scores
   - Quantitative assessment of spatial clustering coherence

**Supported Datasets:**
- **E12.5_rep1/rep2**: Early embryonic development (12.5 days post-conception)
- **E13.5_rep2**: Mid-embryonic development (13.5 days post-conception) 
- **E15.5_rep1/rep2**: Late embryonic development (15.5 days post-conception)

**Methods Applied:**
All 14 SVG detection methods from the main workflow are adapted for spatial ATAC-seq analysis:
- nnSVG, Spanve, SPARK-X, SPARK, SpatialDE2, SpatialDE, SOMDE
- MoranI, scGCO, SpaGCN, SpaGFT, GPcounts, Sepal, BOOST-GP

**Usage:**
```bash
# Run spatial ATAC-seq analysis workflow
cd spatial_atac/
snakemake -s 00_spatial_atac.smk --use-conda --cores <n_cores>

# Run individual analysis notebooks
jupyter notebook 01_get_peaks.ipynb
```

This framework provides insights into which SVG detection methods are most effective for identifying biologically meaningful spatial patterns in chromatin accessibility data during development.

### `snakemake_clustering/`
Comprehensive evaluation framework for assessing how effectively different SVG detection methods improve spatial clustering performance. This workflow systematically compares spatial clustering algorithms using gene sets identified by various SVG detection methods on real spatial transcriptomics datasets.

**Key Objectives:**
- **SVG-informed clustering**: Evaluate whether SVG-selected gene sets improve clustering compared to highly variable genes (HVG)
- **Method comparison**: Compare clustering performance across different SVG detection approaches
- **Parameter optimization**: Test different numbers of top genes for clustering analysis
- **Ground truth validation**: Use manually annotated spatial domains from human DLPFC (Dorsolateral Prefrontal Cortex) data

**Workflow Components:**

1. **Data Preparation** (`01_prepare_data.ipynb`):
   - Process human DLPFC spatial transcriptomics datasets from spatialLIBD
   - Quality control: filter genes (min 200 cells) and cells (min 200 genes)
   - Prepare standardized input data for downstream analysis

2. **SVG Gene Selection** (`02_get_genes.ipynb`):
   - Extract top-ranked genes from each SVG detection method
   - Standardize gene ranking across different methods
   - Generate gene lists with varying sizes (500, 1000, 1500, 2000 genes)

3. **Clustering Evaluation** (`03_eva_clustering.ipynb`):
   - Compute clustering performance metrics (Adjusted Rand Index - ARI)
   - Compare clustering results against ground truth spatial domains
   - Generate performance summaries across all method/parameter combinations

4. **Visualization** (`04_viz.ipynb`):
   - Create comprehensive plots comparing clustering performance
   - Visualize spatial clustering results overlaid on tissue sections
   - Generate comparative analysis plots across methods and datasets

**Supported Datasets:**
12 human DLPFC samples from spatialLIBD project:
- **Sample IDs**: 151507, 151508, 151509, 151510, 151669, 151670, 151671, 151672, 151673, 151674, 151675, 151676
- **Ground truth**: Manual annotation of cortical layers and white matter regions
- **Technology**: 10x Visium spatial transcriptomics

**SVG Detection Methods Evaluated:**
All 14 methods from the main benchmarking workflow:
- nnSVG, Spanve, SPARK-X, SPARK, SpatialDE2, SpatialDE, SOMDE
- MoranI, scGCO, SpaGCN, SpaGFT, GPcounts, Sepal, BOOST-GP
- **Baseline**: HVG (Highly Variable Genes) for comparison

**Spatial Clustering Algorithms:**
- **Leiden**: Community detection algorithm for spatial clustering
- **K-means**: Classic clustering adapted for spatial data
- **BayesSpace**: Bayesian spatial clustering method
- **Banksy**: Spatial transcriptomics clustering incorporating neighborhood information

**Usage:**

1. **Run SVG detection**:
   ```bash
   cd snakemake_clustering/
   snakemake -s svg_snakefile --use-conda --cores <n_cores>
   ```

2. **Run spatial clustering**:
   ```bash
   snakemake -s clustering_snakefile --use-conda --cores <n_cores>
   ```

3. **Analyze results**:
   ```bash
   jupyter notebook 03_eva_clustering.ipynb
   jupyter notebook 04_viz.ipynb
   ```

**Key Parameters:**
- **Gene set sizes**: 500, 1000, 1500, 2000 top-ranked SVGs
- **Clustering resolution**: Optimized for each method
- **Evaluation metric**: Adjusted Rand Index (ARI) against ground truth

This framework provides quantitative evidence for which SVG detection methods produce gene sets that are most informative for spatial clustering, directly demonstrating the biological relevance of different computational approaches.

### `statistical_calibration/`
Statistical validation framework for assessing the calibration and false discovery rate control of SVG detection methods on real spatial transcriptomics data. This analysis ensures that p-values and statistical tests from different methods are properly calibrated and that claimed significance levels correspond to actual error rates.

**Key Objectives:**
- **P-value calibration**: Evaluate whether p-values from SVG methods follow expected uniform distribution under null hypothesis
- **Type I error control**: Assess false positive rates when no spatial signal is expected
- **Method reliability**: Identify methods with well-calibrated statistical tests
- **Cross-technology validation**: Test calibration across different spatial genomics platforms

**Statistical Framework:**

**QQ-plot Analysis**: 
- Quantile-quantile plots comparing observed vs. expected p-value distributions
- Confidence intervals to assess deviations from uniform distribution
- Detection of systematic inflation or deflation of p-values

**Null Data Analysis**:
- Analysis on datasets with minimal expected spatial structure
- Evaluation of false positive rates under null conditions
- Assessment of method-specific statistical behavior

**Workflow Components:**

1. **Mouse Olfactory Bulb Analysis** (`01_prepare_data.ipynb`, `02_plot.ipynb`):
   - **Dataset**: 10x Visium Mouse Olfactory Bulb (`06_10x_Visium_Mouse_Olfactory_Bulb`)
   - **Preprocessing**: Normalization, log-transformation, gene filtering (min 500 cells)
   - **Quality control**: Assessment of spatial gene expression patterns
   - **Statistical analysis**: QQ-plots for p-value calibration assessment

2. **Human Colon Cancer Analysis** (`03_prepare_data.ipynb`, `04_plot.ipynb`):
   - **Dataset**: 10x Xenium Human Colon Cancer (`32_10x_Xenium_Human_Colon_Cancer`)
   - **High-resolution validation**: Single-cell resolution spatial data
   - **Stringent filtering**: Gene filtering with min 2000 cells for robust statistics
   - **Cross-platform validation**: Xenium vs. Visium technology comparison

**Statistical Validation Methods:**

**QQ-Plot Generation** (`gg_qqplot` function):
- Creates quantile-quantile plots with 95% confidence intervals
- Compares observed p-values against uniform distribution expectation
- Identifies methods with proper statistical calibration
- Detects systematic biases in statistical testing

**Key Features:**
- **Confidence intervals**: Account for correlation between tests
- **Visual diagnostics**: Clear identification of calibration issues
- **Robust statistics**: Appropriate for genome-wide multiple testing scenarios

**Supported SVG Methods:**
All 14 methods from the main benchmarking workflow:
- nnSVG, Spanve, SPARK-X, SPARK, SpatialDE2, SpatialDE, SOMDE
- MoranI, scGCO, SpaGCN, SpaGFT, GPcounts, Sepal, BOOST-GP

**Usage:**

1. **Run statistical calibration analysis**:
   ```bash
   cd statistical_calibration/
   snakemake --use-conda --cores <n_cores>
   ```

2. **Generate calibration plots**:
   ```bash
   # Mouse Olfactory Bulb
   jupyter notebook 01_prepare_data.ipynb
   jupyter notebook 02_plot.ipynb
   
   # Human Colon Cancer  
   jupyter notebook 03_prepare_data.ipynb
   jupyter notebook 04_plot.ipynb
   ```

**Expected Outcomes:**
- **Well-calibrated methods**: P-values follow diagonal line in QQ-plots
- **Conservative methods**: Points below diagonal (fewer significant results than expected)
- **Anti-conservative methods**: Points above diagonal (more significant results than expected)
- **Systematic bias**: Consistent deviations from expected uniform distribution

This validation framework ensures that downstream analyses using these SVG detection methods are based on statistically sound and properly calibrated significance testing.