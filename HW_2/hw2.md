##### Problem 1

$$
\mathbf{v}_1=[0,0,0,-x_{i3}'x_{i1},-x_{i3}'x_{i2},-x_{i3}'x_{i3},x'_{i2}x_{i1},x'_{i2}x_{i2},x'_{i2}x_{i3}]^T \\\mathbf{v}_2=[x'_{i3}x_{i1},x'_{i3}x_{i2},x'_{i3}x_{i3},0,0,0,-x_{i1}'x_{i1},-x_{i1}'x_{i2},-x_{i1}'x_{i3}]^T \\\mathbf{v}_3=[-x_{i2}'x_{i1},-x_{i2}'x_{i2},-x_{i2}'x_{i3},x'_{i1}x_{i1},x'_{i1}x_{i2},x'_{i1}x_{i3},0,0,0]^T\\\mathbf{h}=[H_{11},H_{12},H_{13},H_{21},H_{22},H_{23},H_{31},H_{32},H_{33}]^T \\Here \quad \mathbf{H} = \begin{bmatrix} H_{11} & H_{12} & H_{13} \\ H_{21} & H_{22} & H_{23} \\ H_{31} & H_{32} & H_{33} \end{bmatrix}
$$

$\mathbf{v}_1,\mathbf{v}_2,\mathbf{v}_3$ are nod linear independent. Because $x_{i1}'\mathbf{v}_1+x_{i2}'\mathbf{v}_2+x_{i3}'\mathbf{v}_3=0$.

At least 4 correspondences are needed to determine an unique $\mathbf{h}$.

**Proof**:

Because $\mathbf{v}_1,\mathbf{v}_2,\mathbf{v}_3$ are nod linear independent. So a correspondences can offer two equations. And then $\mathbf{h}$ has 8 parameters. So if we hope a unique solution. We need to have 8 equations, because linear equation system's theory(A matrix $A\in\R^{m*n}$ and a vector $b\in\R^m$, when we are searching for solutions of the linear equation system $Ax=b$. For $m=n$, we can find the unique solutions.).

##### Problem 2

(1) The problem is give a dataset $\tilde{X}=[X\quad O]\Pi$, find a hyperplane H that contains all the inliers $X$..

(2)$||\tilde{X}^Tf||_1=\Sigma^{N+M}_{i=1}|\rm{X}_i^Tf|$, $\rm{X}_i$ is a column belong to $X$. So the problem is that:
$$
\min _{f\in\R^9}\Sigma^{N+M}_{i=1}|\tilde{\rm{X}_i}^Tf|\quad s.t. \quad ||f||_2=1.
$$


##### Problem 3

(1) Because $||\tilde{X}^Th||_1=\Sigma^N_{i=1}\Sigma^3_{j=1}|\mathbf{v}_j(x_i,x_i')^Th|$, so the optimal problem can be writed as:
$$
\min_{h\in\R^9}\Sigma^N_{i=1}\Sigma^3_{j=1}|\mathbf{v}_j(x_i,x_i')^Th| \quad s.t. \quad ||h||_2=1.
$$

###### Algorithm 1 IRLS algorithm

```
procedure IRLS(X, c, e, Tmax, delta)
	k = 0; J = 0; dJ = inf;
	hk_1 = argmin||X^T * h||_2 s.t. ||h||_2 = 1;
	while k < Tmax and dJ > e * J:
		J = ||X^T*hk_1||_2;
		k = k + 1;
		hk = argmin Sum_i^{N+M} Sum_j^{3}1 / (v_j(x_i, x_i')^T * hk_1) * (v_j(x_i, x_i')^T * h)^2;
		dj = ||X^T * hk_1||_2 - ||X^T * hk||_2;
		hk_1 = hk;
	end while
	return hk_1;
end procedure
```





请问关于problem3和最后代码结果测试， 我认为按照前面写的，最后每对数据点通过embed形成三个等式，这三个等式形成的子空间是应该属于span(h)^\perp, 加上SfM_Homo_Code.m Visualize data前面的注释，判断最优函数还是类似 \Sigma|v(xi,xi')h|。只是相对于Fundamental matrix estimation而言将数据稍微进行了处理，并且这样求出的h也是正交于embeddings的扩展空间的基时，能求到最小值，不知道这样理解对不对。如果这样是对的话，我对于如何使用加入噪音对程序进行判断正确有疑问，我生成过没有噪音的数据集，我的程序是能很好的得到结果，他能得到我自己设定的H矩阵，但是当使用题目提供的数据的时候，我很难确定我的程序是否正确，因为在我看来他的效果很差，通过我的肉眼观察，我觉得题目的数据的H是=[1 0 0; 0 1 0; 0 0 1]，但是有的点的噪音甚至是原本数据的几倍，导致我认为这个点看作outlier也完全没有问题，我本来想在优化问题中加入其它变量来增加对噪音的抗性，类似《Noisy Dual Principal Component Pursuit》的（2），但也是因为找到了论文，所以觉得原本设定的等式并没有问题，所以我愿意相信程序确实根据这个数据生成了合适的答案，但是如果我的程序有问题的话，我有什么方法判断这个答案就是这样的数据能得到最优答案以此来改良我的程序吗？