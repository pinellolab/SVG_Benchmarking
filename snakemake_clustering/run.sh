# snakemake --snakefile ./svg_snakefile -k --nolock --use-conda --cores 1 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
snakemake --snakefile ./clustering_snakefile -k --nolock --use-conda --cores 100 --rerun-triggers mtime --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
