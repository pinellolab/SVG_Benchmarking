rule SOMDE:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/output/SOMDE/{dataset}.csv"
    conda:
        "zl_SOMDE"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/benchmark/SOMDE/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/04_statistical_calibration/methods/run_SOMDE.py -i {input} -o {output}"