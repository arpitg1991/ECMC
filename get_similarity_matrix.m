function [ sim_matrix ] = get_similarity_matrix( labels )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n = size(labels, 1);
sim_matrix = zeros(n);
for i=1:n
    for j=1:n
        if(labels(i)==labels(j))
            sim_matrix(i, j)=1;
        end
    end
end

end