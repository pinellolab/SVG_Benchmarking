suppressMessages(library(SpatialExperiment))
suppressMessages(library(scran))
suppressMessages(library(nnSVG))
library(optparse)

source("/data/pinello/PROJECTS/2023_03_SVGBenchmarking/workflow/scripts/utils/helper.R")

option_list = list(
    make_option(c("-i", "--input"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character")
)

opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input)

counts <- t(as.matrix(adata$X))
    
colnames(counts) <- adata$obs_names
rownames(counts) <- adata$var_names
    
loc <- as.data.frame(adata$obsm[['spatial']])

row_data = adata$var
row_data$gene_id = rownames(row_data)
row_data$feature_type = "Gene Expression"

colnames(loc) <- c("x", "y")
rownames(loc) <- colnames(counts)

spe <- SpatialExperiment(
    assays = list(counts = counts),
    rowData = row_data,
    colData = loc, 
    spatialCoordsNames = c("x", "y"))

# calculate logcounts (log-transformed normalized counts) using scran package
# using library size factors
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

set.seed(123)
spe <- nnSVG(spe, n_threads=10)

df <- rowData(spe)

write.csv(df, file=opt$output, quote=FALSE)