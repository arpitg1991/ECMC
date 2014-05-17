%Load Data here%
clusters = 6 ; 
clusteringMethods = 3 ;
trueLabels = newsGroup_labels ; 
%load('._NG20_kmeans_pp_medoids.mat')
% load('current.mat')
% load('NG20_kmeans_pp_medoids.mat')
% load('C:\Users\Arpit\Desktop\amlproject\workspaces\._NG20_kmeans_pp_medoids.mat')
% load('C:\Users\Arpit\Desktop\amlproject\workspaces\current.mat')
% load('C:\Users\Arpit\Desktop\amlproject\workspaces\NG20_kmeans_pp_medoids.mat')
tm1 = csvread('TM\NG20BetterClusters.csv');
tm100 = csvread('TM\NG20clusters.csv');

%%
clusteringMethod1 = kmeansLabels  ;
clusteringMethod2  = kmdd'; 
clusteringMethod3 = kmpp' ; 
clusteringMethod4  = tm1 ; 

%%
%%Create Similarity matrix
sim1 = CreateSimilarity (clusteringMethod1  ) ;
sim2 =  CreateSimilarity (clusteringMethod2  ) ;
sim3 = CreateSimilarity (clusteringMethod3  )  ;
sim = sim1 + sim2 + sim3  ; 
if ( clusteringMethods >=4 )
    sim4 = CreateSimilarity (clusteringMethod4  ) ;

    sim = sim + sim4 ; 
end
if ( clusteringMethods >=5 )
    sim5 = CreateSimilarity (clusteringMethod5  ) ;

    sim = sim + sim5 ; 
end

%%
%Remove spurious entries
minme = 1 ; 
maxme = clusteringMethods -1 ; 
partialMatrix = createBlanks(sim , minme, maxme,clusteringMethods ) ;


%%
%Perform Matrix Completion
cd('inexact_alm_mc\')
completeMatrix = inexact_alm_mc(partialMatrix) ;
completeMatrix1 = completeMatrix ; 
completeMatrix = completeMatrix.U*completeMatrix.V' ;
cd ..
%%
%Spectral clustering 
completeMatrix = completeMatrix + abs(min(min(completeMatrix)));
completeMatrix = completeMatrix + 0.000001 ;
completeMatrix = 1./ completeMatrix ;
predictedLabels = sc(completeMatrix,0,clusters);
nmi(trueLabels+1,predictedLabels);


