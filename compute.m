function [ accuracy ] = compute( X, y, clusters, d1, d2, labels_TM)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

higher = 2;
middle = 0;
lower = -2;

%% Normal Clustering
labels_kmeans = kmeans(X, clusters);
labels_kmeanspp = kmeanspp(X', clusters)';
labels_kmedoids = kmedoids(X', clusters)';

%% Get similarity
sim_kmeans = get_similarity_matrix(labels_kmeans);
sim_kmeanspp = get_similarity_matrix(labels_kmeanspp);
sim_kmedoids = get_similarity_matrix(labels_kmedoids);
sim_TM = get_similarity_matrix(labels_TM);

%% Add similarity
sum_sim = sim_kmeans + sim_kmeanspp + sim_kmedoids + sim_TM;

%% Sample
sum_sampled = sum_sim;
sum_sampled(sum_sampled<=d1) = lower;
sum_sampled(sum_sampled>d1 & sum_sampled<d2) = middle;
sum_sampled(sum_sampled>=d2) = higher;

%% Matrix completion
[output iter svp] = inexact_alm_mc(sum_sampled);
output = output.U*output.V';

%% Spectral clustering


%% Compute Results
accuracy = 1;


end

