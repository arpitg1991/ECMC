newsGroup = csvread('datasets_final\NG20.csv') ;
%%
kmeansLabels = kmeans(newsGroup,6) ;
kmdd = kmedoids (newsGroup',6) ;
%%
kmpp = kmeanspp(newsGroup',6);
