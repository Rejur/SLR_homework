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
cAddPos = sortrows(cAddPos); % �����ĵڶ��У���Ϊ PI * A = I����������ԭ����λ�ã� ͨ���ڶ��н����û����Եõ��������顣
% tmp1_idx = zeros(m, 1);
tmp2_idx = zeros(m, 1);
tmp3_idx = zeros(m, 1);
% disp(yAddPos);
for index = 1:m
    % disp(cAddPos(index, 2))
    % tmp1_idx(cAddPos(index , 2) , 1) = index;
    tmp2_idx(yAddPos(index , 2) , 1) = index; % ͨ������λ�÷�����дindex���Ǹ���I���ֵȥ�Ĳſ��Եõ�A��PI^-1��
    tmp3_idx(index, 1) = cAddPos(index, 2);
end
% disp(tmp1_idx);
% disp(tmp2_idx);
% disp(tmp3_idx);
Pi_idx = tmp3_idx(tmp2_idx,:);
% disp(C(Pi_idx,:));
end

