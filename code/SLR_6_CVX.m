%% script for running the brute force algorithm

%% parameters:
m = 10;
n = 4;
%sigma = 0.00797885;
% sigma = 0.0157£»
sigma = 0.01;
shuffled_ratio = 0;
errors1 = 0;
errors2 = 0;
%% generate data:
for i = 1:20
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);

%% run the algorithm
cvx_begin
    variable x_hat1(n)
    minimize(norm(y - A * x_hat1, 1))
cvx_end

%% evaluation

l = 0.5;
cvx_begin
    variable x_hat2(n);
    variable e(m);
    minimize( (1 / m) * (norm(y - A * x_hat2 - (m^0.5)*e))^2 + l * (norm(e,1)) );
cvx_end;
%disp(x);
%disp(x_hat1);
error = norm(x_hat1 - x) / norm(x);
errors1 = errors1 + error;
%disp(error);
%disp(x_hat2);
error = norm(x_hat2 - x) / norm(x);
errors2 = errors2 + error;
%disp(error);
end
disp(errors1 / 30);
disp(errors2 / 30);