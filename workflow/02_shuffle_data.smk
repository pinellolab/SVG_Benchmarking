from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/shuffle_data/nnSVG.smk"
include: "rules/shuffle_data/Spanve.smk"
include: "rules/shuffle_data/SPARKX.smk"
include: "rules/shuffle_data/SPARK.smk"
include: "rules/shuffle_data/SpatialDE2.smk"
include: "rules/shuffle_data/SpatialDE.smk"
include: "rules/shuffle_data/SOMDE.smk"
include: "rules/shuffle_data/MoranI.smk"
include: "rules/shuffle_data/scGCO.smk"
include: "rules/shuffle_data/SpaGCN.smk"
include: "rules/shuffle_data/SpaGFT.smk"
include: "rules/shuffle_data/GPcounts.smk"
include: "rules/shuffle_data/Sepal.smk"
include: "rules/shuffle_data/BOOST-GP.smk"
           
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal', 'BOOST-GP']

methods = ['SpatialDE2', 'GPcounts']
      
datasets = ['V1_Adult_Mouse_Brain_shuffle', 'V1_Adult_Mouse_Brain_raw']
               
rule all:
    input:
        expand("results/shuffle_data/{method}/{dataset}.csv", method=methods, dataset=datasets)
