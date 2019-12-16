function [distances, f, resIter, time] = DPCP_IRLS_modified(X_tilde, delta, T, epsilon_J)
    tic;

    [D, N] = size(X_tilde);
    % display([D,N]);
    Delta_J = Inf;
    k = 0;
    w = ones(N, 1);
    J_old = zeros(N, 1);
    J_new = zeros(N, 1);
    resIter = 0;
    while (Delta_J > epsilon_J) 
        resIter = resIter + 1;
        R_X = X_tilde * diag(w) * X_tilde';
        [U, S, V] = svd(R_X);
        % display(U);
        f = U(:,D);

        for j = 1:N
            w(j) = 1 / max(delta, norm(f' * X_tilde(:, j)));
            % display(f' * X_tilde(:, j));
            % display(norm(f' * X_tilde(:, j)));
            J_new(j) = norm(f' * X_tilde(:, j));
        end

        k = k + 1;
        Delta_J = abs(sum(J_old) - sum(J_new)) / (sum(J_old) + 10^(-9));
        J_old = J_new;
    end

    distances = zeros(1, N);

    for j = 1:N
        distances(j) = norm(f' * X_tilde(:, j));
    end
    time = toc;
end
