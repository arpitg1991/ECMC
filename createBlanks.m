function b = createBlanks(b,low,high,clusteringMethods)
    %remove entries between low and high, included
    minmax = clusteringMethods  ;
    n = size(b,1) ; 
    parfor i = 1:n
        for j = 1:n
            if ( b(i,j) < low ) 
                b(i,j) = -clusteringMethods ; 
            elseif ( b(i,j) > high ) 
                b(i,j) = clusteringMethods ; 
            else
                b(i,j) = 0 ; 
            end
        end
    end
    
   
end