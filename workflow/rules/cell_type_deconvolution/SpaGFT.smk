rule run_SpaGFT:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/SpaGFT/{dataset}.csv"
    conda:
        "SpaGFT"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/SpaGFT/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_SpaGFT.py -i {input} -o {output}"