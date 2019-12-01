%% parameters:
m = 10;
n = 4;
sigma = 0;
shuffled_ratio = 0;
%% generate data:
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);
disp("End gen data");
% x0 = ones(n,1);
x0 = ((transpose(A) * A) \ transpose(A)) * y;
x_hat = SLR_4_AltMin(A, y, x0, 100);

%% evaluation
error = norm(x_hat - x) / norm(x);
disp(x_hat);
disp(x);
disp(error);
