rule SPARK:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/output/SPARK/{dataset}.csv"
    conda:
        "zl_SPARK"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/benchmark/SPARK/{dataset}.txt"
    shell:
        "Rscript /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/04_statistical_calibration/methods/run_SPARK.R -i {input} -o {output}"