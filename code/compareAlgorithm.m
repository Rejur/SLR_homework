%% script for running the brute force algorithm

%% parameters:
m = 20;
n = 12;
%sigma = 0.00797885;
% sigma = 0.0157；
sigma = 0.01;
errors1Plot = [];
errors2Plot = [];
errorsAMPlot = [];
for j=1:11
shuffled_ratio = (j-1)*10;
errors1 = 0;
errors2 = 0;
errorsAM = 0;
%% generate data:
for i = 1:20
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);

%% run the algorithm
cvx_begin
    variable x_hat1(n)
    minimize(norm(y - A * x_hat1, 1))
cvx_end

l = 0.5;
cvx_begin
    variable x_hat2(n);
    variable e(m);
    minimize( (1 / m) * (norm(y - A * x_hat2 - (m^0.5)*e))^2 + l * (norm(e,1)) );
cvx_end;

x0 = ((transpose(A) * A) \ transpose(A)) * y;
x_hat = SLR_4_AltMin(A, y, x0, 10);

error = norm(x_hat - x) / norm(x);
errorsAM = error + errorsAM;

error = norm(x_hat1 - x) / norm(x);
errors1 = errors1 + error;
error = norm(x_hat2 - x) / norm(x);
errors2 = errors2 + error;
end
errors1Plot = [errors1Plot, errors1 / 20];
errors2Plot = [errors2Plot, errors2 / 20];
errorsAMPlot = [errorsAMPlot, errorsAM / 20];
end
plot(errors1Plot,'r');
hold on
plot(errors2Plot,'b');
hold on
plot(errorsAMPlot,'g');
grid on
xlabel("混乱数据比例/单位：10%");
ylabel("error");
legend('5.2','5.3','AM')