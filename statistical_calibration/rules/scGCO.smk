rule scGCO:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/output/scGCO/{dataset}.csv"
    conda:
        "scGCO"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/benchmark/scGCO/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/04_statistical_calibration/methods/run_scGCO.py -i {input} -o {output}"