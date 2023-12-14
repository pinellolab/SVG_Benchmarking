from snakemake.utils import min_version

##### set minimum snakemake version #####
min_version("6.4.1")

include: "rules/scalability/nnSVG.smk"
include: "rules/scalability/Spanve.smk"
include: "rules/scalability/SPARKX.smk"
include: "rules/scalability/SPARK.smk"
include: "rules/scalability/SpatialDE2.smk"
include: "rules/scalability/SpatialDE.smk"
include: "rules/scalability/SOMDE.smk"
include: "rules/scalability/MoranI.smk"
include: "rules/scalability/scGCO.smk"
include: "rules/scalability/SpaGCN.smk"
include: "rules/scalability/SpaGFT.smk"
include: "rules/scalability/GPcounts.smk"
include: "rules/scalability/Sepal.smk"
include: "rules/scalability/BOOST-GP.smk"
           
methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK', 'SpatialDE2',
           'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN',
           'SpaGFT', 'GPcounts', 'Sepal', 'BOOST-GP']

methods = ['nnSVG', 'Spanve', 'SPARK-X', 'SPARK']
methods = ['SpatialDE2', 'SpatialDE', 'SOMDE', 'MoranI', 'scGCO', 'SpaGCN']
methods = ['SpaGCN']
           
datasets = ['10X_Visium_10x_V1_Human_Brain_Section_2_filtered_feature_bc_matrix_data',
            '10X_Visium_gracia2021genome_archivalcancer_V10F24-111_D1_data',
            '10X_Visium_bergenstrahle2021super_human_ileum_V19T26-028_A1_data',
            '10X_Visium_10x_Visium_FFPE_Adult_Mouse_Brain_data',
            '10X_Visium_10x_V1_Mouse_Kidney_filtered_feature_bc_matrix_data',
            'DBiT-seq_liu2020high_E10_eye_and_nearby_data',
            'DBiT-seq_liu2020high_GSM4364245_E11-FL-2L_gene_data',
            'DBiT-seq_liu2020high_E10_brain_gene_25um_data',
            'DBiT-seq_liu2020high_E10_whole_gene_best_data',
            'DBiT-seq_liu2020high_GSM4189613_0702cL_gene_data',
            'Slide-seqV2_stickels2020highly_stickels2021highly_Slide-seqV2_Mouse_Hippocampus_Puck_200115_08_data_whole',
            'Slide-seqV2_chen2021dissecting_Diabetes_3_data_whole',
            'Slide-seqV2_chen2021dissecting_WT1_data_whole',
            'Slide-seqV2_stickels2020highly_stickels2021highly_SlideSeqV2_Mouse_Olfactory_bulb_Puck_200127_15_data_whole']
            
datasets = ['n_spots_100', 'n_spots_500', 'n_spots_1000', 'n_spots_2000', 'n_spots_5000',
            'n_spots_7500', 'n_spots_10000', 'n_spots_15000', 'n_spots_20000', 'n_spots_40000']
       
rule all:
    input:
        expand("results/scalability/{method}/{dataset}.csv", method=methods, dataset=datasets)
