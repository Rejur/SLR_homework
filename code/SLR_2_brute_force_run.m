% script for running the brute force algorithm

%% parameters: 
m = 0;
n = 0;
sigma = 0;
shuffled_ratio = 0;

%% generate data:
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);

%% run the algorithm
x_hat = SLR_2_brute_force(A, y);

%% evaluation
error = norm(x_hat - x) / norm(x);