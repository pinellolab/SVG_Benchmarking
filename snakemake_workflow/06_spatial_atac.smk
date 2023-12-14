from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/spatial_atac/nnSVG.smk"
include: "rules/spatial_atac/Spanve.smk"
include: "rules/spatial_atac/SPARKX.smk"
include: "rules/spatial_atac/SPARK.smk"
include: "rules/spatial_atac/SpatialDE2.smk"
include: "rules/spatial_atac/SpatialDE.smk"
include: "rules/spatial_atac/SOMDE.smk"
include: "rules/spatial_atac/MoranI.smk"
include: "rules/spatial_atac/scGCO.smk"
include: "rules/spatial_atac/SpaGCN.smk"
include: "rules/spatial_atac/SpaGFT.smk"
include: "rules/spatial_atac/GPcounts.smk"
include: "rules/spatial_atac/BOOST-GP.smk"
include: "rules/spatial_atac/Sepal.smk"
           
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal']

methods = ['Spanve']

datasets = ['E12_5_rep1', 'E12_5_rep2', 'E13_5_rep2', 'E15_5_rep1', 'E15_5_rep2']
            
rule all:
    input:
        expand("results/spatial_atac/{method}/{dataset}.csv", method=methods, dataset=datasets)
