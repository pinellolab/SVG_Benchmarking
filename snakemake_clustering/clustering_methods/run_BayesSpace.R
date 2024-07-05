suppressMessages(library(BayesSpace))
suppressMessages(library(optparse))
suppressMessages(library(scater))
suppressMessages(library(anndataR))

option_list = list(
    make_option(c("--input_data"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("--input_genes"), type="character", default=NULL, 
              help="dataset file name", metavar="character"),
    make_option(c("-o", "--output"), type="character", default=NULL, 
              help="output file name [default= %default]", metavar="character")
)
 
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

adata <- read_h5ad(opt$input_data)
df_svgs <- read.csv(opt$input_genes)

counts <- as.matrix(adata$layers[['counts']])
colnames(counts) <- adata$var_names
rownames(counts) <- adata$obs_names
mode(counts) <- 'integer'

df_obs <- as.data.frame(adata$obsm[['spatial']]) 
rownames(df_obs) <- adata$obs_names
colnames(df_obs) <- c("col", "row")

df_obs$spatialLIBD <- adata$obs$spatialLIBD

# create SingleCellExperiment object
sce <- SingleCellExperiment(list(counts=t(counts)), colData=df_obs)
sce <- computeLibraryFactors(sce)
sce <- logNormCounts(sce)

sce <- scater::runPCA(sce, subset_row=df_svgs$gene)

## Add BayesSpace metadata
sce <- spatialPreprocess(sce, platform="Visium", skip.PCA=TRUE)

n_clusters <- length(unique(df_obs$spatialLIBD))

## Run BayesSpace clustering
set.seed(104)
sce <- spatialCluster(sce, 
                      q = n_clusters, 
                      d = 15, 
                      platform='Visium', 
                      gamma=3, save.chain=FALSE)

df <- as.data.frame(colData(sce))[c("spatialLIBD", "spatial.cluster")]
colnames(df) <- c('spatialLIBD', 'clusters')

write.csv(df, file=opt$output, quote=FALSE)
