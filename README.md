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

The simulated data are provided here for downloading.

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
Analysis scripts and workflows specifically for spatial ATAC-seq data, focusing on identifying spatially variable chromatin accessibility peaks.

### `snakemake_clustering/`
Snakemake workflows for spatial clustering analysis, including data preparation and clustering evaluation across different methods and parameters.

### `statistical_calibration/`
Methods and scripts for statistical calibration of SVG detection methods, including false discovery rate control and method comparison frameworks.