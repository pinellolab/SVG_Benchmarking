rule run_SpaGFT:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/SpaGFT/{dataset}.csv"
    conda:
        "SpaGFT"
    threads: 10
    benchmark:
        "benchmarks/clustering/SpaGFT/{dataset}.txt"
    shell:
        "python scripts/clustering/run_SpaGFT.py -i {input} -o {output}"