function [partPkCoef] = cnt_part_of_coeffs(A, k, n, resK, deep, partPkCoef, iPerm)
    if  resK == 0
        cnt = size(iPerm, 2);
        coef = factorial(k);
        for i = 1 : cnt
            coef = (coef / factorial(iPerm(1, i))) * A(1, i)^(iPerm(1, i));
        end
        partPkCoef = [partPkCoef; coef];
        return;
    end
    if deep == n
        % disp(233);
        return;
    end
    for i = resK : -1 : 0 
       % disp(i);
       partPkCoef = cnt_part_of_coeffs(A, k, n, resK - i, deep + 1, partPkCoef, [iPerm, i]);
    end
end