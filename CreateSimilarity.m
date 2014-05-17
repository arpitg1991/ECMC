function simMatrix  = CreateSimilarity ( clusteringMatrix ) 
    
    d = pdist ( clusteringMatrix) ;
    d = d == 0 ; 
    d = squareform(d) ;
    I = eye(size(clusteringMatrix,1));
    simMatrix = d + I ;
    
end