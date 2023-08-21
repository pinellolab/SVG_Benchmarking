rule run_Spanve:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/CellTypeDeconvolution/data/{dataset}.h5ad"
    output:
        "results/cell_type_deconvolution/Spanve/{dataset}.csv"
    conda:
        "Spanve"
    threads: 10
    benchmark:
        "benchmarks/cell_type_deconvolution/Spanve/{dataset}.txt"
    shell:
        "python scripts/cell_type_deconvolution/run_Spanve.py -i {input} -o {output}"