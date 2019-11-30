%% parameters: 
m = 4;
n = 3;
sigma = 0.01;
shuffled_ratio = 100;
errorsRS = [];
errorsBF = [];

%% start test:

for i = 1:100
%% generate data:
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);
% disp("End gen data");
x_hat = SLR_3_RANSAC(A, y);
%% evaluation
error = norm(x_hat - x) / norm(x);
errorsRS = [errorsRS, error];
x_hat = SLR_2_brute_force(A, y);
error = norm(x_hat - x) / norm(x);
errorsBF = [errorsBF, error];
end

disp("errorsRS=");
disp(mean(errorsRS));
disp("errorsBF=");
disp(mean(errorsBF));
