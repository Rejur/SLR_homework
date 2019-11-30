% script for running the brute force algorithm
%% parameters:
m = 5;
n = 3;
shuffled_ratio = 0;
l = 0;
r = 1;
eps = 1e-16;
while l <= r
    errors = 0;
    sigma = (l + r) / 2;
    %disp(l);
    %disp(r);
    for i = 1 : 10000
        [A, y, x] = SLR_1_gen_data(m, n, sigma, shuffled_ratio);
        % x_hat = ((transpose(A) * A) \ transpose(A)) * y;
        x_hat = SLR_2_brute_force(A, y);
        error = norm(x_hat - x) / norm(x);
        errors = errors + error;
    end
    % disp(errors);
    if errors < 1
        l = sigma + eps;
    elseif errors >= 1
        r = sigma - eps;
    end 
end
disp(l);