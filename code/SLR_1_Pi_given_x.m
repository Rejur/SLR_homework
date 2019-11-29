function [Pi_idx] = SLR_1_Pi_given_x(A, y, x)
% Pi_idx is a m-dimensional vector such that Pi*A = A(Pi_idx, :)
C = A * x;
m = size(A, 1);
% disp(m);
yAddPos = [transpose(y);(1:m)];
yAddPos = transpose(yAddPos);
cAddPos = [transpose(C);(1:m)];
cAddPos = transpose(cAddPos);
yAddPos = sortrows(yAddPos);
cAddPos = sortrows(cAddPos); % 排序后的第二列，作为 PI * A = I，代表它们原来的位置， 通过第二列进行置换可以得到正序数组。
% tmp1_idx = zeros(m, 1);
tmp2_idx = zeros(m, 1);
tmp3_idx = zeros(m, 1);
% disp(yAddPos);
for index = 1:m
    % disp(cAddPos(index, 2))
    % tmp1_idx(cAddPos(index , 2) , 1) = index;
    tmp2_idx(yAddPos(index , 2) , 1) = index; % 通过根据位置反向填写index，是告诉I这个值去哪才可以得到A即PI^-1。
    tmp3_idx(index, 1) = cAddPos(index, 2);
end
% disp(tmp1_idx);
% disp(tmp2_idx);
% disp(tmp3_idx);
Pi_idx = tmp3_idx(tmp2_idx,:);
% disp(C(Pi_idx,:));
end

