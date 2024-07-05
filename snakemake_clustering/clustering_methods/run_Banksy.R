suppressMessages(library(Banksy))
suppressMessages(library(SummarizedExperiment))
suppressMessages(library(SpatialExperiment))
suppressMessages(library(scuttle))
suppressMessages(library(scater))
suppressMessages(library(cowplot))
suppressMessages(library(ggplot2))
suppressMessages(library(anndataR))
suppressMessages(library(optparse))
suppressMessages(library(Seurat))

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

locs <- as.matrix(adata$obsm[['spatial']]) 
rownames(locs) <- adata$obs_names
colnames(locs) <- c("col", "row")

se <- SpatialExperiment(assay = list(counts = t(counts)), 
                        spatialCoords = locs, 
                        colData = adata$obs)


#' Normalize data
seu <- as.Seurat(se, data = NULL)
seu <- Seurat::NormalizeData(seu)

#' Add data to SpatialExperiment and subset to HVGs
aname <- "normcounts"
assay(se, aname) <- GetAssayData(seu)
se <- se[df_svgs$gene, ]

k_geom <- c(15, 30)

se <- Banksy::computeBanksy(se, assay_name = aname, compute_agf = TRUE, k_geom = k_geom)

set.seed(1000)
se <- Banksy::runBanksyPCA(se, use_agf = TRUE, lambda = 0.2, npcs = 30)
se <- Banksy::runBanksyUMAP(se, use_agf = TRUE, lambda = 0.2)
se <- Banksy::clusterBanksy(se, use_agf = TRUE, lambda = 0.2, algo = "leiden")

df <- as.data.frame(colData(se))[c("spatialLIBD", "clust_M1_lam0.2_k50_res1")]
colnames(df) <- c('spatialLIBD', 'clusters')

write.csv(df, file=opt$output, quote=FALSE)
