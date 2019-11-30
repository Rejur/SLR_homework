% script for running the brute force algorithm

%% parameters: 
m = 3;
n = 2;
sigma = 0.00797885;
shuffled_ratio = 0;

%% generate data:
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);

x_hat = ((transpose(A)*A) \ transpose(A))* y;
disp(x_hat);
error = norm(x_hat - x) / norm(x);
disp(error);
%% run the algorithm
x_hat = SLR_2_brute_force(A, y);

%% evaluation
error = norm(x_hat - x) / norm(x);