rule run_Sepal:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/Sepal/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/clustering/Sepal/{dataset}.txt"
    shell:
        "python scripts/clustering/run_Sepal.py -i {input} -o {output}"