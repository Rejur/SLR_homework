function [X_tilde] = homographic_embeddings(x1, x2)
    %??è¿?x1??x2???????¢æ????è¦????°æ????
    len = size(x1, 2);
    X_tilde = zeros([9, len * 3]);

    for index = 1:len
        X_tilde(:, (index - 1) * 3 + 1) = [0; 0; 0; -x2(3, index) * x1(1, index); -x2(3, index) * x1(2, index); -x2(3, index) * x1(3, index); x2(2, index) * x1(1, index); x2(2, index) * x1(2, index); x2(2, index) * x1(3, index)];
        X_tilde(:, (index - 1) * 3 + 2) = [x2(3, index) * x1(1, index); x2(3, index) * x1(2, index); x2(3, index) * x1(3, index);
        0; 0; 0;
        -x2(1, index) * x1(1, index); -x2(1, index) * x1(2, index); -x2(1, index) * x1(3, index)];
        X_tilde(:, (index - 1) * 3 + 3) = [-x2(2, index) * x1(1, index); -x2(2, index) * x1(2, index); -x2(2, index) * x1(3, index);
        x2(1, index) * x1(1, index); x2(1, index) * x1(2, index); x2(1, index) * x1(3, index);
        0; 0; 0];
    end

    % return X_tilde
end
