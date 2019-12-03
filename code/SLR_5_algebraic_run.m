addpath('libs');

%% parameters: 
% NOTE: in this exercise n is limited to be 2,3,4,5.
figure;
m = 100;
for n = 3:3
sigma = 0;
shuffled_ratio = 10;
c = zeros(1, 4);
c1 = 0;
c2 = 0;
c3 = 0;
c4 = 0;
c5 = 0;
c6 = 0;
c7 = 0;
c8 = 0;
errors = 0;
%% generate data:
parfor i = 1:1000
    disp(i);
[A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);

%% run the algorithm
% tic
x_hat = SLR_5_algebraic(A, y);
% toc
%% evaluation
error = norm(x_hat - x) / norm(x);
errors = errors + error;
if error < 10^(-14)
    %c(1, 1) = c(1, 1) + 1;
    c1 = c1 + 1;
elseif error < 10^(-12)
    c2 = c2 + 1;
elseif error < 10^(-10)
    c3 = c3 + 1;
elseif error < 10^(-8)
   % c(1, 2) = c(1, 2) + 1;
    c4 = c4 + 1;
elseif error < 10^(-6)
    %c(1, 3) = c(1, 3) + 1;
    c5 = c5 + 1;
elseif error < 10^(-4)
    c6 = c6 + 1;
elseif error < 10^(-2)
    c7 = c7 + 1;
else
    %c(1, 4) = c(1, 4) + 1;
    c8 = c8 + 1;
end

end
disp(errors);
%disp(x_hat);
%disp(x);
subplot(1,3,n - 2);
b = bar([c1, c2, c3, c4, c4, c5, c6, c7, c8]);
ch = get(b,'children');
set(ch,'FaceVertexCData',[4;2;3;1]);
set(gca,'XTickLabel',{'C1','C2','C3','C4','C5','C6','C7','C8'})
ylabel('times');
end

pwd = 'D:\';
name = num2str(n);
pwd = [pwd name '.jpeg'];
print(gcf,'-djpeg',pwd); 