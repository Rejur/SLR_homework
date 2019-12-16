##### Problem 1

$$
\mathbf{v}_1(\mathbf{x}_i,\mathbf{x}_i')=[0,0,0,-x_{i3}'x_{i1},-x_{i3}'x_{i2},-x_{i3}'x_{i3},x'_{i2}x_{i1},x'_{i2}x_{i2},x'_{i2}x_{i3}]^T \\\mathbf{v}_2(\mathbf{x}_i,\mathbf{x}_i')=[x'_{i3}x_{i1},x'_{i3}x_{i2},x'_{i3}x_{i3},0,0,0,-x_{i1}'x_{i1},-x_{i1}'x_{i2},-x_{i1}'x_{i3}]^T \\\mathbf{v}_3(\mathbf{x}_i,\mathbf{x}_i')=[-x_{i2}'x_{i1},-x_{i2}'x_{i2},-x_{i2}'x_{i3},x'_{i1}x_{i1},x'_{i1}x_{i2},x'_{i1}x_{i3},0,0,0]^T\\\mathbf{h}=[H_{11},H_{12},H_{13},H_{21},H_{22},H_{23},H_{31},H_{32},H_{33}]^T \\Here \quad \mathbf{H} = \begin{bmatrix} H_{11} & H_{12} & H_{13} \\ H_{21} & H_{22} & H_{23} \\ H_{31} & H_{32} & H_{33} \end{bmatrix}
$$

$\mathbf{v}_1,\mathbf{v}_2,\mathbf{v}_3$ are nod linear independent. Because $x_{i1}'\mathbf{v}_1+x_{i2}'\mathbf{v}_2+x_{i3}'\mathbf{v}_3=0$.

At least 4 correspondences are needed to determine an unique $\mathbf{h}$.

**Proof**:

Because $\mathbf{v}_1,\mathbf{v}_2,\mathbf{v}_3$ are nod linear independent. So a correspondences can offer two equations. And then $\mathbf{h}$ has 8 parameters. So if we hope a unique solution. We need to have 8 equations, because linear equation system's theory(A matrix $A\in\R^{m*n}$ and a vector $b\in\R^m$, when we are searching for solutions of the linear equation system $Ax=b$. For $m=n$, we can find the unique solutions.).

##### Problem 2

(1) The problem is give a dataset $\tilde{X}=[X\quad O]\Pi$, to find a hyperplane H that contains all the inliers $X$. In other world, we hope find a vector to make the equation's answer is the sparsest. 

(2)$||\tilde{X}^Tf||_1=\Sigma^{N+M}_{i=1}|\rm{X}_i^Tf|$, $\rm{X}_i$ is a column belong to $X$. So the problem is that:
$$
\min _{f\in\R^9}\Sigma^{N+M}_{i=1}|\tilde{\rm{X}_i}^Tf|\quad s.t. \quad ||f||_2=1.
$$


##### Problem 3

(1) Because $||\tilde{X}^Th||_1=\Sigma^N_{i=1}\Sigma^3_{j=1}|\mathbf{v}_j(x_i,x_i')^Th|$, so the optimal problem can be writed as:
$$
\min_{h\in\R^9}\Sigma^N_{i=1}\Sigma^3_{j=1}|\mathbf{v}_j(x_i,x_i')^Th| \quad s.t. \quad ||h||_2=1.
$$

我认为按照前面写的，最后每对数据点通过embed形成三个等式，这三个等式形成的子空间是应该属于$span(h)^\perp$, 这样的等式已经符合我最后的需求，如果考虑三个等式是从一对对应点生成能获得三个向量线性相关的条件，我认为可以只使用两个等式就构成我的最优函数，但是，实际测试的时候，在高噪音的情况下，会使得outlier出现在inlier范围中，相比于三个等式部分inlier不在我们求到的最优空间中，我认为应该在保证精确率的情况下提高准确率，所以还是依然使用三个等式构造最优函数。

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





##### Problem 4

I tested the data without noise, and I found that my algorithm worked and got the answer. But when I tested the data given by the homework, I originally calculated the distance. There should be 300 points in the span space we asked for, but actually only about 250 points were in the span space. I think it is because some points are very noisy, which leads to a particularly large error when constructing new equations, making these points float out of the span space like outliers. (The result is as follows)

![show](/Users/hulin/Desktop/SLR_homework/HW_2/show.jpg)