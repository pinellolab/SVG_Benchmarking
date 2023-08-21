rule run_BOOSTGP:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/BOOST-GP/{dataset}.csv"
    conda:
        "BOOST-GP"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/BOOST-GP/{dataset}.txt"
    shell:
        "Rscript scripts/cell_type_deconvolution/run_BOOST-GP.R -i {input} -o {output}"