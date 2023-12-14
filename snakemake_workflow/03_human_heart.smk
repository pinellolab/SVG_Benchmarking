from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/human_heart/nnSVG.smk"
include: "rules/human_heart/Spanve.smk"
include: "rules/human_heart/SPARKX.smk"
include: "rules/human_heart/SPARK.smk"
include: "rules/human_heart/SpatialDE2.smk"
include: "rules/human_heart/SpatialDE.smk"
include: "rules/human_heart/SOMDE.smk"
include: "rules/human_heart/MoranI.smk"
include: "rules/human_heart/scGCO.smk"
include: "rules/human_heart/SpaGCN.smk"
include: "rules/human_heart/SpaGFT.smk"
include: "rules/human_heart/GPcounts.smk"
include: "rules/human_heart/BOOST-GP.smk"
include: "rules/human_heart/Sepal.smk"

            
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal']

methods = ['GPcounts']
      
datasets = ['FZ_10X0027', 'FZ_10X009', 'FZ_ACH005', 'FZ_ACH006', 'FZ_ACH007', 'FZ_ACH008']
               
rule real_data:
    input:
        expand("results/human_heart/{method}/{dataset}.csv", method=methods, dataset=datasets)
