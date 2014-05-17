function [indices, cluster_centers] = SpectralClustering(similarity_matrix, topKvectors)
    %{
    similarity_matrix must be symmetric matrix else the eigen values are
    complex, topKvectors must be a number. 
    %}

    %Usage
    %{
    
    num_datapoints = 100;
    topKvectors = 10;
    similarity_matrix = rand(num_datapoints,num_datapoints);
    similarity_matrix = similarity_matrix*similarity_matrix';
    [indices, cluster_centers] = SpectralClustering(similarity_matrix,topKvectors);
    %}

    num_datapoints = size(similarity_matrix,1);
    diag_mat = zeros(size(similarity_matrix));
    
    
    % generation of diagonal matrix equation (2)
    for i=1:size(similarity_matrix,1)
        diag_mat(i,i)=sum(similarity_matrix(i,:));
    end
    %L = I -diag_mat^-0.5* S* D^-0.5;
    I = eye(num_datapoints);
    sqrt_D = sqrtm(diag_mat);
    % A\b = inv(A)*b; b/A = b*inv(A)
    first_prod = (sqrt_D\similarity_matrix);
    laplacian_ = I- ( first_prod/sqrt_D );
    % laplacian is a diag matrix
    [vectors,~]=eig(laplacian_);

    % top k eigen vectors  are the last k columns in eigen vectors matrix as
    % eigen vectors are ordered in increasing order of eigen values by matlab
    % top k vectors are (:,n-k+1:n)
    % k  <= n

    V = vectors(:,size(vectors,2)-topKvectors+1:size(vectors,2));
     % size of V is (n,k) which is top k eigen vectors.
     % U = normalised_matrix_V
    U = V;
    for i=1: size(U,1)
        row_vec = U(i,:);
        root_sum_sqr = rssq(row_vec);
        for j=1: size(V,2)
            U(i,j)= U(i,j)/root_sum_sqr;
        end
    end

    [indices,cluster_centers] =  kmeans(U,topKvectors);
end