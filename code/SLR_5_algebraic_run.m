addpath('libs');

%% parameters: 
% NOTE: in this exercise n is limited to be 2,3,4,5.

m = 100;
for n = 5:5
sigma = 0;
shuffled_ratio = 0;
c = zeros(1, 4);
%% generate data:
for i = 1:1000
    % disp(i);
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);

%% run the algorithm
% tic
x_hat = SLR_5_algebraic(A, y);
% toc
%% evaluation
error = norm(x_hat - x) / norm(x);
if error < 10^(-12)
    c(1, 1) = c(1, 1) + 1;
elseif error < 10^(-8)
    c(1, 2) = c(1, 2) + 1;
elseif error < 10^(-4)
    c(1, 3) = c(1, 3) + 1;
else
    c(1, 4) = c(1, 4) + 1;
end
end
%disp(x_hat);
%disp(x);
figure;
subplot(1,3,n - 2);
b = bar(c);
ch = get(b,'children');
set(ch,'FaceVertexCData',[4;2;3;1]);%使用Indexed形式指定每组bar的颜色
set(gca,'XTickLabel',{'C1','C2','C3','C4'})
ylabel('times');
pwd = '~/';
name = num2str(n);
pwd = [pwd name '.jpeg'];
print(gcf,'-djpeg',pwd); 
end