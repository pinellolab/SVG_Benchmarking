rule run_Sepal:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/Sepal/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/Sepal/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_Sepal.py -i {input} -o {output}"