function [x_hat] = SLR_5_algebraic(A, y)
    

    [m, n] = size(A);
    if n == 1 || n > 5
        disp("no solver available");
        x_hat = 0;
    end
    
    %% convert our data A, y into the inputs needed for "libs/solver_SLR_nk.m".
        data = coeffs_from_A_y(A, y);
    %% run the solver, which produces 
    if n == 2
        X_complex = solver_SLR_n2(data);
    elseif n == 3
        X_complex = solver_SLR_n3(data);
    elseif n == 4
        X_complex = solver_SLR_n4(data);
    elseif n == 5
        X_complex = solver_SLR_n5(data);
    end
    % disp(data);
    % disp(X_complex);
    %% root selection
        x0 = root_selection(X_complex, A, y);
    %% alternating minimization refinement
        num_iter = 100;
        % disp(x0);
        x_hat = SLR_4_AltMin(A, y, x0, num_iter);
end

function [data] = coeffs_from_A_y(A, y)
% data [output] is a vector. Its first n entries are 
%                         the constant coefficients in p1,p2, ... pn,
%                         i.e., sum(y.^k). 
%                  The rest elements are [coefficients of monomials in p1; 
%                                         coefficients of monomials in p2; ...
%                                         coefficients of monomials in pn;]
%   Example: if p2 = 3*x1^2 + 4*x1*x2 + 5*x2^2 + 6
%            then data(2) = 6;
%                 [coefficients of monomials in p2] = [3;4;5];
%   the monomials are assumed to be in lexicographical order:
%            https://en.wikipedia.org/wiki/Monomial
%            https://en.wikipedia.org/wiki/Monomial_order
%            https://en.wikipedia.org/wiki/Lexicographical_order

    n = size(A, 2);
    m = size(A, 1);
    yn = zeros(n, 1);
    data0 = [];
    for k = 1:n
        yn(k,1) = sum(y.^k);    
        %% implementation: modify data0 so that it fits the specification above
        %% if this specification is unclear to you, contact me.
        data1 = 0;
        for i = 1 : m
            tmpCoef = cnt_part_of_coeffs(A(i,:), k, n, k, 0, [], []);
            if data1 == 0
                data1 = tmpCoef;
            else
                data1 = data1 + tmpCoef;
            end
        end
        data0 = [data0; data1];
    end
    data = [yn; data0];
end

function x0 = root_selection(X_complex, A, y)
% implement this function
    %disp(X_complex);
    cnt = size(X_complex, 2);
    miniError = inf;
    for i = 1 : cnt
        x_hat = real(X_complex(:, i));
        % disp(x_hat);
        PiPerm = SLR_1_Pi_given_x(A, y, x_hat);
        error = norm(y - A(PiPerm, :) * x_hat);
        if error < miniError
            miniError = error;
            x0 = x_hat;
        end
    end
end
