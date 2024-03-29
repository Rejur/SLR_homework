%% parameters: 
m = 8;
n = 6;
sigma = 0.01;
shuffled_ratio = 100;
%% generate data:
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);
disp("End gen data");
x_hat = SLR_3_RANSAC(A, y);

%% evaluation
error = norm(x_hat - x) / norm(x);
disp(x_hat);
disp(x);
disp(error);