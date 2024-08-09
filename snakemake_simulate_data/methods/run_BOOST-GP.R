library(RcppDist)
library(optparse)

source("/data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/utils/BOOST-GP/boost.gp.R")
source("/data/pinello/PROJECTS/2023_03_SVGBenchmarking/scripts/utils/helper.R")


option_list = list(
    make_option(c("-i", "--input"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character")
)
 
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input)

counts = as.matrix(adata$layers[['counts']])
colnames(counts) <- adata$var_names
rownames(counts) <- adata$obs_names
mode(counts) <- 'integer'

loc <- as.data.frame(adata$obsm[['spatial']]) 
rownames(loc) <- adata$obs_names
colnames(loc) <- c("x", "y")
df <- as.data.frame(boost.gp(Y = counts, loc = loc, iter=10, burn=5))

df_true <- adata$var
df <- merge(df, df_true, by = "row.names", all = TRUE)
df[is.na(df)] <- 1
rownames(df) <- df$Row.names

write.csv(df, file=opt$output, quote=FALSE)
