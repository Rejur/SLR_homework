function [x_hat] = SLR_3_RANSAC(A, y)
    % x_hat: the final estimate
    m = size(A, 1);
    n = size(A, 2);
    odrAperm = nchoosek((1:m), n);
    icnt = size(odrAperm, 1);
    minm = inf;
    ychooseperm = sort(randperm(m, n));
    ybar = y(ychooseperm, :);

    for index = 1:icnt
        nodrAperm = perms(odrAperm(index, :));
        jcnt = size(nodrAperm, 1);

        for jndex = 1:jcnt
            Ai = A(nodrAperm(jndex, :), :);
            x = Ai \ ybar;
            Pi_idx = SLR_1_Pi_given_x(A, y, x);
            error = norm(y - A(Pi_idx, :) * x);

            if error < minm
                minm = error;
                Ansx = x;
                AnsPi = Pi_idx;
            end

        end

    end

    Pi = AnsPi;
    disp(Pi);
    x_hat = Ansx;
end
