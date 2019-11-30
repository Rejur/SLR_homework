function [A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio)
% y = Pi*A*x + sigma*noise
shuffledNum = round(shuffled_ratio * m / 100);
if shuffledNum < 1
    shuffledNum = 0;
else
    shuffledNum = min(m, max(2, shuffledNum));
end

% disp(shuffledNum)
A = rand([m n]);
x = rand([n 1]);
Ax = A * x;
% disp(A);
% disp(Ax);
% disp((1 : shuffledNum))
while true
    rndPerm = randperm(shuffledNum);
    if sum(rndPerm == (1 : shuffledNum)) == 0
        break;
    end
end
% disp(rndPerm)
Ax(1:shuffledNum) = Ax(rndPerm);
% disp(Ax);
y = Ax + normrnd(0, sigma^2, [m, 1]);
end

