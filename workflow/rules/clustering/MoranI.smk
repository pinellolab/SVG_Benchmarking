rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataClustering/filtered/{dataset}.h5ad"
    output:
        "results/clustering/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/clustering/MoranI/{dataset}.txt"
    shell:
        "python scripts/clustering/run_MoranI.py -i {input} -o {output}"