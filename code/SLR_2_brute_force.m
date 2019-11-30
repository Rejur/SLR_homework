function [x_hat] = SLR_2_brute_force(A, y)
% x_hat: the final estimate
m = size(A, 1);
n = size(A, 2);
v = (1:m);
P = perms(v);
cnt = factorial(m);
minnum = inf;
flag = 0;
for index = 1:cnt
    Pi = P(index, : );
    tmpA = A(Pi , :);
    if m == n
        x_hat = tmpA \ y;
    elseif m > n
        x_hat = ((transpose(tmpA)*tmpA) \ transpose(tmpA))* y;
    elseif m < n
        x_hat = (transpose(tmpA)*tmpA) \ (transpose(tmpA) * y);
    end
    if norm(y - tmpA * x_hat) < minnum
        minnum = norm(y - tmpA * x_hat);
        flag = index;
        Ansx = x_hat;
    end
end
Pi = P(flag, :);
disp(Pi);
x_hat = Ansx;
end

