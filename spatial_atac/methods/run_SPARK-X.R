library(SPARK)
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

counts <- t(as.matrix(adata$layers[['counts']]))
    
colnames(counts) <- adata$obs_names
rownames(counts) <- adata$var_names
    
info <- as.data.frame(adata$obsm[['spatial']])
rownames(info) <- colnames(counts)
colnames(info) <- c("x", "y")
    
sparkX <- sparkx(counts, info[, 1:2], numCores=10, option="mixture")
df <- as.data.frame(sparkX$res_mtest)

df <- merge(df, adata$var, by = "row.names", all = TRUE)
df[is.na(df)] <- 1
rownames(df) <- df$Row.names

write.csv(df, file=opt$output, quote=FALSE)