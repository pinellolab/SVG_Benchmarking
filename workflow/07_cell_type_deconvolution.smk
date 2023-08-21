from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/cell_type_deconvolution/nnSVG.smk"
include: "rules/cell_type_deconvolution/Spanve.smk"
include: "rules/cell_type_deconvolution/SPARKX.smk"
include: "rules/cell_type_deconvolution/SPARK.smk"
include: "rules/cell_type_deconvolution/SpatialDE2.smk"
include: "rules/cell_type_deconvolution/SpatialDE.smk"
include: "rules/cell_type_deconvolution/SOMDE.smk"
include: "rules/cell_type_deconvolution/MoranI.smk"
include: "rules/cell_type_deconvolution/scGCO.smk"
include: "rules/cell_type_deconvolution/SpaGCN.smk"
include: "rules/cell_type_deconvolution/SpaGFT.smk"
include: "rules/cell_type_deconvolution/GPcounts.smk"
include: "rules/cell_type_deconvolution/BOOST-GP.smk"
include: "rules/cell_type_deconvolution/Sepal.smk"
           
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal']
           
methods = ['nnSVG', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal']
           
datasets = ['MOBSP']
            
rule all:
    input:
        expand("results/cell_type_deconvolution/{method}/{dataset}.csv", method=methods, dataset=datasets)
