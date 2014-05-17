function b = createBlanks(b,low,high,clusteringMethods)
    %remove entries between low and high, included
    minmax = clusteringMethods /2 ;
    b(b< low)= -1 * minmax;
    b(b>=low & b<=high)=0;
    b(b>high) = minmax;
end