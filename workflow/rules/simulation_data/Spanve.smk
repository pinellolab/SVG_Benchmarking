rule run_Spanve_covariance:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Covariance_v2/sigma_{sigma}_alpha_{alpha}.h5ad"
    output:
        "results/simulation_data/covariance_based/Spanve/sigma_{sigma}_alpha_{alpha}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/simulation_data/covariance_based/Spanve/sigma_{sigma}_alpha_{alpha}.txt"
    shell:
        "python scripts/simulation_data/run_Spanve.py  -i {input} -o {output}"
        
        
rule run_Spanve_clustering:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Clustering/{tissue}_logfc_{logfc}.h5ad"
    output:
        "results/simulation_data/clustering_based/Spanve/{tissue}_logfc_{logfc}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/simulation_data/clustering_based/Spanve/{tissue}_logfc_{logfc}.txt"
    shell:
        "python scripts/simulation_data/run_Spanve.py -i {input} -o {output}"
