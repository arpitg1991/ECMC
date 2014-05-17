
%% Load data
load NG20
load reuters
load NYTimes

%% Compute K-means/K-means++

clusters = 6;
NG20_kmeans = kmeans(NG20, clusters);
reuters_kmeans = kmeans(reuters, clusters);
NYT_kmeans = kmeans(NYTimes, clusters);

%% Compute K-medoids

NG20_kmedoids = kmedoids(NG20, clusters);
reuters_kmedoids = kmedoids(reuters, clusters);
NYT_kmedoids = kmedoids(NYTimes, clusters);

%% Compute Similarity matrix

NG20_kmeans_sim = get_similarity_matrix(NG20_kmeans);
reuters_kmeans_sim = get_similarity_matrix(reuters_kmeans);
NYT_kmeans_sim = get_similarity_matrix(NYT_kmeans);

NG20_kmedoids_sim = get_similarity_matrix(NG20_kmedoids);
reuters_kmedoids_sim = get_similarity_matrix(reuters_kmedoids);
NYT_kmedoids_sim = get_similarity_matrix(NYT_kmedoids);

%% Add the results

sum_sim_NG20 = NG20_kmeans_sim + NG20_kmedoids_sim;
sum_sim_reuters = reuters_kmeans_sim + reuters_kmedoids_sim;
sum_sim_NYT = NYT_kmeans_sim + NYT_kmedoids_sim;

%% Sample points


%% Perform matrix completion

[A iter svp] = inexact_alm_mc(matrix);