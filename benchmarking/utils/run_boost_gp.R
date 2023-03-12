library(anndata)
library(RcppDist)
library(optparse)
source("BOOST-GP/boost.gp.R")

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
loc <- as.data.frame(adata$obsm[['spatial']])
    
df <- as.data.frame(boost.gp(Y = counts, loc = loc, iter=100, burn=50))
    
df_var <- adata$var
df_var$spatially_variable <- as.integer(df_var$spatially_variable)

df <- df[rownames(df_var), ]
df$spatially_variable <- as.integer(df_var$spatially_variable)
df <- df[, c("pval", "spatially_variable")]
    
write.csv(df, file=opt$output, quote=FALSE)