#snakemake --snakefile ./00_simulation_data.smk -k --nolock --use-conda --cores 100 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
#snakemake --snakefile ./01_scalability.smk -k --use-conda --cores 10 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
#snakemake --snakefile ./02_shuffle_data.smk -k --nolock --use-conda --cores 10 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
#snakemake --snakefile ./03_human_heart.smk -k --use-conda --cores 10 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
#snakemake --snakefile ./04_clustering.smk -k --nolock --use-conda --cores 10 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
#snakemake --snakefile ./05_real_data_shuffle.smk -k --nolock --use-conda --cores 50 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
snakemake --snakefile ./06_spatial_atac.smk -k --nolock --use-conda --cores 1 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
#snakemake --snakefile ./07_cell_type_deconvolution.smk -k --nolock --use-conda --cores 50 --conda-base-path /data/pinello/SHARED_SOFTWARE/anaconda_latest
