
plotError = [];
for i = 1:11
%% parameters:
m = 30;
n = 4;
sigma = 0;
shuffled_ratio = (i - 1) * 10;
errors = 0;
for j = 1:100
%% generate data:
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);
% disp("End gen data");
% x0 = ones(n,1);
x0 = ((transpose(A) * A) \ transpose(A)) * y;
x_hat = SLR_4_AltMin(A, y, x0, 10);

%% evaluation
error = norm(x_hat - x) / norm(x);
errors = errors + error;
end
plotError = [plotError, errors / 100];
end
plot(plotError);