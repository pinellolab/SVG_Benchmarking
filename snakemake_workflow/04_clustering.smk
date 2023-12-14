from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/clustering/nnSVG.smk"
include: "rules/clustering/Spanve.smk"
include: "rules/clustering/SPARKX.smk"
include: "rules/clustering/SPARK.smk"
include: "rules/clustering/SpatialDE2.smk"
include: "rules/clustering/SpatialDE.smk"
include: "rules/clustering/SOMDE.smk"
include: "rules/clustering/MoranI.smk"
include: "rules/clustering/scGCO.smk"
include: "rules/clustering/SpaGCN.smk"
include: "rules/clustering/SpaGFT.smk"
include: "rules/clustering/GPcounts.smk"
include: "rules/clustering/BOOST-GP.smk"
include: "rules/clustering/Sepal.smk"

           
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal']
           
datasets = ['151507', '151508', '151509', '151510', '151669', '151670', 
            '151671', '151672', '151673', '151674', '151675', '151676']
            
rule all:
    input:
        expand("results/clustering/{method}/{dataset}.csv", method=methods, dataset=datasets)
