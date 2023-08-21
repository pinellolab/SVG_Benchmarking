from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/real_data_shuffle/nnSVG.smk"
include: "rules/real_data_shuffle/Spanve.smk"
include: "rules/real_data_shuffle/SPARKX.smk"
include: "rules/real_data_shuffle/SPARK.smk"
include: "rules/real_data_shuffle/SpatialDE2.smk"
include: "rules/real_data_shuffle/SpatialDE.smk"
include: "rules/real_data_shuffle/SOMDE.smk"
include: "rules/real_data_shuffle/MoranI.smk"
include: "rules/real_data_shuffle/scGCO.smk"
include: "rules/real_data_shuffle/SpaGCN.smk"
include: "rules/real_data_shuffle/SpaGFT.smk"
include: "rules/real_data_shuffle/GPcounts.smk"
include: "rules/real_data_shuffle/BOOST-GP.smk"
include: "rules/real_data_shuffle/Sepal.smk"
include: "rules/real_data_shuffle/BOOST-GP-v2.smk"
           
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal']

methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'Sepal', 'BOOST-GP']
           
methods = ['BOOST-GP-v2']
           
datasets = ['151507', '151508', '151509', '151510', '151669', '151670', 
            '151671', '151672', '151673', '151674', '151675', '151676']
            
rule all:
    input:
        expand("results/real_data_shuffle/{method}/{dataset}.csv", method=methods, dataset=datasets)
