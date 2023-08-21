rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/RealWorldDataSVGs/data/{dataset}.h5ad"
    output:
        "results/real_data_shuffle/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/real_data_shuffle/MoranI/{dataset}.txt"
    shell:
        "python scripts/real_data_shuffle/run_MoranI.py -i {input} -o {output}"