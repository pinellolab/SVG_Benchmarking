library(SPARK)
library(anndata)
library(optparse)

option_list = list(
    make_option(c("-i", "--input"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character")
)
 
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input)
counts = t(as.matrix(adata$layers[['counts']]))
info <- as.data.frame(adata$obsm[['spatial']])
rownames(info) <- colnames(counts)
colnames(info) <- c("x", "y")
info$total_counts = apply(counts, 2, sum)
    
spark <- CreateSPARKObject(counts=counts, 
                            location=info[, 1:2])
spark@lib_size <- apply(spark@counts, 2, sum)
spark <- spark.vc(spark, 
                   covariates = NULL, 
                   lib_size = spark@lib_size, 
                   num_core = 20,
                   verbose = F)
    ## Calculating pval
spark <- spark.test(spark, 
                     check_positive = T, 
                     verbose = F)
    
df_var <- adata$var
df_var$spatially_variable <- as.integer(df_var$spatially_variable)

df <- as.data.frame(spark@res_mtest)
df <- df[rownames(df_var), ]
df$spatially_variable <- as.integer(df_var$spatially_variable)
df <- df[, c("adjusted_pvalue", "spatially_variable")]
    
write.csv(df, file=opt$output, quote=FALSE)