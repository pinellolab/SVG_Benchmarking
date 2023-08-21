rule run_BOOST_GP_covariance:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Covariance_v2/sigma_{sigma}_alpha_{alpha}.h5ad"
    output:
        "results/simulation_data/covariance_based/BOOST-GP/sigma_{sigma}_alpha_{alpha}.csv"
    conda:
        "BOOST-GP"
    threads: 10
    benchmark:
        "benchmarks/simulation_data/covariance_based/BOOST-GP/sigma_{sigma}_alpha_{alpha}.txt"
    shell:
        "Rscript scripts/simulation_data/run_BOOST-GP.R -i {input} -o {output}"
        
        
rule run_BOOST_GP_clustering:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/SimulationData/Clustering/{tissue}_logfc_{logfc}.h5ad"
    output:
        "results/simulation_data/clustering_based/BOOST-GP/{tissue}_logfc_{logfc}.csv"
    conda:
        "BOOST-GP"
    threads: 10
    benchmark:
        "benchmarks/simulation_data/clustering_based/BOOST-GP/{tissue}_logfc_{logfc}.txt"
    shell:
        "Rscript scripts/simulation_data/run_BOOST-GP.R -i {input} -o {output}"