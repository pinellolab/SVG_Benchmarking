import pandas as pd

def get_svgs_by_p_value(df, method, cutoff=0.05):
    if method == 'nnSVG':
        df_sub = df[df['adjustedPval']] <= cutoff
        return df['Row.names'].tolist()
    
    elif method == 'SPARK-X':
        df_sub = df[df['adjustedPval']] <= cutoff
        return df['Row.names'].tolist()
    
    
    if method == 'SPARK-X':
        df['adjustedPval'] = - df['adjustedPval']
    elif method == 'SPARK':
        df['adjusted_pvalue'] = - df['adjusted_pvalue']
    elif method == 'scGCO':
        df['fdr'] = - df['fdr']
    elif method == 'SpaGCN':
        df['pvals_adj'] = - df['pvals_adj']
        
    if method == 'GPcounts':
        df['log_likelihood_ratio'] = df['log_likelihood_ratio'].fillna(0)
    
    if method == 'nnSVG':
        corr = groupby.apply(lambda x: x['prop_sv'].corr(x['spatial_var'], method='spearman'))
    elif method == 'Spanve':
        corr = groupby.apply(lambda x: x['ent'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SPARK-X':
        corr = groupby.apply(lambda x: x['adjustedPval'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SPARK':
        corr = groupby.apply(lambda x: x['adjusted_pvalue'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SpatialDE2':
        corr = groupby.apply(lambda x: x['FSV'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SpatialDE':
        corr = groupby.apply(lambda x: x['FSV'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SOMDE':
        corr = groupby.apply(lambda x: x['FSV'].corr(x['spatial_var'], method='spearman'))        
    elif method == 'MoranI':
        corr = groupby.apply(lambda x: x['I'].corr(x['spatial_var'], method='spearman'))
    elif method == 'scGCO':
        corr = groupby.apply(lambda x: x['fdr'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SpaGCN':
        corr = groupby.apply(lambda x: x['pvals_adj'].corr(x['spatial_var'], method='spearman'))
    elif method == 'SpaGFT':
        corr = groupby.apply(lambda x: x['gft_score'].corr(x['spatial_var'], method='spearman'))
    elif method == 'GPcounts':
        corr = groupby.apply(lambda x: x['log_likelihood_ratio'].corr(x['spatial_var'], method='spearman'))
    elif method == 'Sepal':
        corr = groupby.apply(lambda x: x['sepal_score'].corr(x['spatial_var'], method='spearman'))
    elif method == 'BOOST-GP':
        corr = groupby.apply(lambda x: x['PPI'].corr(x['spatial_var'], method='spearman'))
    else:
        print(f'unknown method: {method}')
        
    return corr