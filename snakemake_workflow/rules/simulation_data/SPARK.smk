rule run_SPARK_covariance:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Covariance_v2/sigma_{sigma}_alpha_{alpha}.h5ad"
    output:
        "results/simulation_data/covariance_based/SPARK/sigma_{sigma}_alpha_{alpha}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/simulation_data/covariance_based/SPARK/sigma_{sigma}_alpha_{alpha}.txt"
    shell:
        "Rscript scripts/simulation_data/run_SPARK.R -i {input} -o {output}"
        
        
rule run_SPARK_clustering:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Clustering/{tissue}_logfc_{logfc}.h5ad"
    output:
        "results/simulation_data/clustering_based/SPARK/{tissue}_logfc_{logfc}.csv"
    conda:
        "SPARK"
    threads: 10
    benchmark:
        "benchmarks/simulation_data/clustering_based/SPARK/{tissue}_logfc_{logfc}.txt"
    shell:
        "Rscript scripts/simulation_data/run_SPARK.R -i {input} -o {output}"