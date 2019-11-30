function [x_hat] = SLR_3_RANSAC(A, y)
    % x_hat: the final estimate
    m = size(A, 1);
    n = size(A, 2);
    odrAperm = nchoosek((1:m), n);
    icnt = size(odrAperm, 1);
    minm = inf;
    ychooseperm = sort(randperm(m, n));
    ybar = y(ychooseperm, :);
    xiSet = zeros(n, (m - n + 1) * nchoosek(m, n) * factorial(n));
    cnt = 1;

    for index = 1:icnt
        nodrAperm = perms(odrAperm(index, :));
        jcnt = size(nodrAperm, 1);

        for jndex = 1:jcnt
            Ai = A(nodrAperm(jndex, :), :);
            x = Ai \ ybar;
            xiSet(:, cnt) = x;
            cnt = cnt + 1;
        end

    end

    icnt = size(xiSet, 2);

    for index = 1:icnt
        xi = xiSet(:, index);
        Pi_idx = SLR_1_Pi_given_x(A, y, xi);
        error = norm(y - A(Pi_idx, :) * xi);

        if error < minm
            minm = error;
            Ansx = xi;
            AnsPi = Pi_idx;
        end

    end

    Pi = AnsPi;
    disp(Pi);
    x_hat = Ansx;
end
