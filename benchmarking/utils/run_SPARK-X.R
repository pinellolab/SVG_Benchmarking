library(SPARK)
library(anndata)
library(optparse)

option_list = list(
    make_option(c("-i", "--input"), type="character", default=NULL, 
              help="input file name, must be an Anndata file", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character"),
    make_option(c("-s", "--simulate"), default=FALSE, action = "store_true", 
              help="For simulated data, save the true labels and prediction")
)
 
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input)
counts = t(as.matrix(adata$layers[['counts']]))
info <- as.data.frame(adata$obsm[['spatial']])
rownames(info) <- colnames(counts)
colnames(info) <- c("x", "y")

sparkX <- sparkx(counts, info[, 1:2], numCores=10, option="mixture")
df <- as.data.frame(sparkX$res_mtest)

if(opt$simulate){
    # combine the dataframe by rownames
    df_true <- adata$var
    df <- merge(df, df_true, by = "row.names", all = TRUE)
    df[is.na(df)] <- 1
    rownames(df) <- df$Row.names
    df$spatially_variable <- as.integer(df$spatially_variable)
    df <- df[, c("adjustedPval", "spatially_variable")]

}

write.csv(df, file=opt$output, quote=FALSE)