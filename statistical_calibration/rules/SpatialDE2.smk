rule SpatialDE2:
    input:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/{dataset}.h5ad"
    output:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/output/SpatialDE2/{dataset}.csv"
    conda:
        "zl_spatialDE2"
    threads: 10
    benchmark:
        "/data/pinello/PROJECTS/2023_03_SVGBenchmarking/results/04_statistical_calibration/benchmark/SpatialDE2/{dataset}.txt"
    shell:
        "python /data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/04_statistical_calibration/methods/run_SpatialDE2.py -i {input} -o {output}"