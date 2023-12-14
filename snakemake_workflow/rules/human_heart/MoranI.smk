rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/HumanHeart/AnnData/processed_data/{dataset}.h5ad"
    output:
        "results/human_heart/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/human_heart/MoranI/{dataset}.txt"
    shell:
        "python scripts/real_data/run_MoranI.py -i {input} -o {output}"