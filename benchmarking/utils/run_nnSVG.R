suppressMessages(library(SpatialExperiment))
suppressMessages(library(scran))
suppressMessages(library(nnSVG))
suppressMessages(library(ggplot2))
suppressMessages(library(anndata))
library(optparse)

option_list = list(
    make_option(c("-i", "--input"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character"),
    make_option(c("-s", "--simulate"), default=FALSE, action = "store_true", 
              help="For simulated data, save the true labels and prediction")
)
 
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input)
counts <- t(as.matrix(adata$X))
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

if(opt$simulate){
    df <- df[, c("padj", "spatially_variable")]
    df$spatially_variable <- as.integer(df$spatially_variable)
}

write.csv(df, file=opt$output, quote=FALSE)