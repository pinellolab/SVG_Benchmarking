library(SpatialPCA)
library(ggplot2)

source("/data/pinello/PROJECTS/2023_03_SVGBenchmarking/workflow/scripts/utils/BOOST-GP/boost.gp.R")
source("/data/pinello/PROJECTS/2023_03_SVGBenchmarking/Benchmarking/utils/helper.R")

option_list = list(
    make_option(c("-i", "--input"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character")
)
 
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input)

counts = as.matrix(adata$X)
colnames(counts) <- adata$var_names
rownames(counts) <- adata$obs_names
mode(counts) <- 'integer'

loc <- as.data.frame(adata$obsm[['spatial']]) 
rownames(loc) <- adata$obs_names
colnames(loc) <- c("x", "y")
df <- as.data.frame(boost.gp(Y = counts, loc = loc, iter=50, burn=10))
write.csv(df, file=opt$output, quote=FALSE)