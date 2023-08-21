rule run_MoranI:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/MoranI/{dataset}.csv"
    conda:
        "zl_svg"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/MoranI/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_MoranI.py -i {input} -o {output}"