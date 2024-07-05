# snakemake --snakefile ./BOOST-GP.sm -k --nolock --use-conda --cores 100 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest --rerun-triggers mtime
# snakemake --snakefile ./GPcounts.sm -k --nolock --use-conda --cores 10 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
snakemake -k --nolock --use-conda --cores 1 --rerun-triggers mtime --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
