function [x_hat, e_hat] = SLR_4_AltMin(A, y, x0, num_iter)
% x0: the initialization
% num_iter: the number of iterations the algorithm run
%           set it to be large enough if not sure, 100 is a typical choice.
% x_hat: the final estimate
% e_hat: the objective function value
ans = [];
error = norm(y - A * x0);
ans = [ans, error];
x1 = x0;
if num_iter == 0
while true
    % disp(x0);
    Pi = SLR_1_Pi_given_x(A, y, x0);
    Aperm = A(Pi, :);
    x0 = ((transpose(Aperm) * Aperm) \ transpose(Aperm)) * y;
    error = norm(y - Aperm * x0);
    ans = [ans, error];
    if norm(x1 - x0) / norm(x0) < 1e-16
        break;
    end
    x1 = x0;
    % disp(error);
end
else
    for i = 1 : num_iter
        Pi = SLR_1_Pi_given_x(A, y, x0);
        Aperm = A(Pi, :);
        x0 = ((transpose(Aperm) * Aperm) \ transpose(Aperm)) * y;
        error = norm(y - Aperm * x0);
        ans = [ans, error];
    end
end
% disp(ans);
plot((1:size(ans, 2)), ans);

x_hat = x0;
e_hat = norm(y - A(Pi, :) * x0);
end

