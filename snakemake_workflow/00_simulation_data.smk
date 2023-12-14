from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/simulation_data/nnSVG.smk"
include: "rules/simulation_data/Spanve.smk"
include: "rules/simulation_data/SPARKX.smk"
include: "rules/simulation_data/SPARK.smk"
include: "rules/simulation_data/SpatialDE2.smk"
include: "rules/simulation_data/SpatialDE.smk"
include: "rules/simulation_data/SOMDE.smk"
include: "rules/simulation_data/MoranI.smk"
include: "rules/simulation_data/scGCO.smk"
include: "rules/simulation_data/SpaGCN.smk"
include: "rules/simulation_data/SpaGFT.smk"
include: "rules/simulation_data/GPcounts.smk"
include: "rules/simulation_data/Sepal.smk"
include: "rules/simulation_data/BOOST-GP.smk"
include: "rules/simulation_data/BOOST-GP-v2.smk"

methods = ['nnSVG', 'Spanve',  'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal', 'BOOST-GP']

methods = ['BOOST-GP-v2']

sigmas = [0.5, 1.0, 1.5, 2.0, 2.5, 3.0]
alphas = [0.0, 0.2, 0.4, 0.6, 0.8]        
tissues = ["human_DLPFC_151508", "human_DLPFC_151674", "breast_tumor"]
logfcs = [0.5, 1, 1.5, 2]  
    
rule all:
    input:
        expand("results/simulation_data/covariance_based/{method}/sigma_{sigma}_alpha_{alpha}.csv", method=methods, sigma=sigmas, alpha=alphas),
        # expand("results/simulation_data/clustering_based/{method}/{tissue}_logfc_{logfc}.csv", method=methods, tissue=tissues, logfc=logfcs)