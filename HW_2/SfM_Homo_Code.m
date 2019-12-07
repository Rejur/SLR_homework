load('SfM_Homo_Data.mat');

% A set of L=250 correspondences are given, i.e., x1(:, i) <-> x2(:, i) for
% i = 1, ..., L. Points are represented in homogeneous coordinates. As a
% ground-truth information, the first 100 coorespondences are inliers while
% the rest 150 of them are outliers. While you may use the ground-truth for
% debugging purpose, your output should not depend on the ground-truth
% information that which ones are inliers/outliers. We will run your code
% on different test data to ensure the correctness of your result.


% YOUR CODE: Compute a matrix X_tilde that contains embeddings for all the
% correspondences. Remember that in homography matrix estimation, each
% correspondence gives 3 embeddings. Therefore, X_tilde is expected to have
% size 9*3L.
X_tilde = homographic_embeddings(x1, x2);

% Normalize the embeddings to have the unit norm.
X_tilde = normc(X_tilde);

% YOUR CODE: Learn a subspace from X_tilde, using your modification of
% DPCP-IRLS as described in problem 3. 
[h, num_iter, time] = DPCP_IRLS_modified(X_tilde);

% Visualize the subspace distance for each embedding to Span(h)^\perp
figure; stem(abs(normc(h)'*X_tilde));

% For debugging purpose, you may also want to learn a subspace using the
% original DPCP-IRLS algorithm, and perform the same visualization. What do
% you find?



