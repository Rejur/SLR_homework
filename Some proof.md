# SLR_Homework

##### Exercise 1.2:

Because A and x are known, so problem is $\mathop{argmin}_{\Pi\in P}||y-\Pi c||_2$, It is mean I want $||y - c_\Pi||_2^2$'s answer is minimum. $||y-c_\Pi||_2^2 = \Sigma_1^m(y_i-c_{\Pi i})^2=\Sigma_1^m(y_i^2+c_{\Pi i}^2) -2\Sigma_1^m y_ic_{\Pi i}$. By sequence inequality, we know when When order is order， $\Sigma_1^my_ic_{\Pi i}$ is maximum，so the answer is minimum. 

(Unique) Because out of order is smaller than bigger, and In Probability $c_{\Pi i}==c_{\Pi j}$ is zero probability event,  In computer, I think it is a impossible event by use matlab try lots of times, so the solution is unique.

```
Algorithm 1
Input y, A, x
Output Pi
Start:
	sort(y) and record their origin location s1
	sort(c) and record their origin location s2
	Generate Pi from s1 and s2
End
```

so the complexity is $O(mlogm)$.

##### Exercise 2.1:

It easy to knows $y=Ax^*$ by least-squares, so can get minimum by $x^*$.

the error is equal $||(A^TA)^{-1}A\zeta||/||x||$, Generally, when n = 1 and m = 1, then the question is to know $|(A^{-1}\zeta)|/|x| \le 1/100$, $E(\zeta)=\delta \sqrt{2/\pi}$,$E(A)=E(x)=\sqrt{2/\pi}$, so we can know $\delta \le \sqrt{2/\pi}/100$, the error's exception is less than $1\%$.(I try use code to count when sigma = 0.0050, the error is less than $1\%%$).

##### Exercise 2.2:

Complexity, I don't know matlab's full permutation algorithm. But I know use next_permutation(A C++ function) can get all permutations in $O(m^2)$. and get x_hat's complex is $O(m*n^2+n^3+n^2*m)$, so the complex is $O(m!*(m*n^2+n^3+n^2*m))$. Generally speaking, the computer counts 1e8 times in one second, and 1e11 times in one hour. So when $n^2m!(m+n) < 1e11$, the algorithm will to be effcient. And the algorithm is equal to Exercise 2.1, so $\delta \le \sqrt{2/\pi}/100$ can get small error(I try use code to count when sigma = 0.0161, the error is less than $1\%%$). And the algorithm can toperate 100% shuffled data.



##### Exercise 3.1:

```
Given:
		A - a Model parameters from y = PAx + zeta
		y - function's output, a set of observations
		
Return:
    bestFit – data parameters which best fit the function

minerror = inf
bestFit = null
XSet = null
ybar = random subvector in Rn of y

for Ai in all n*n matrixes formed by the rows of A {
  xi = Ai's inverse matrix * yi
  add xi point into XSet
}

for xi in XSet {
	Pi = SLR_1_Pi_given_x(A, y, xi)
	error = norm(y - PiAx)
	if error < minerror {
		minerror = error
		bestFit = xi
	}
}
return bestFit
```

Algorithm has $m! / (m - n)!$ times iterations, and each iterations, compute inverse matrix is $O(n^3)$, other matrix operation is $O(n^2)$ can be ignored, because $m > n$, so PiA is $O(m*n)$, I don't ignore it.

The complex is $O((m!) / (m - n)! * (n^3 + n*m))$. Moreover $m > n$, I write complex is $O(n*m!*(n^2+m)/(m-n)!)$. 

$m=\{20,40,60,80,100,120,140,160,180,200\}$ 

$n=\{6,5,4,4,4,3,3,3,3,3\}$



<img src="/Users/hulin/Library/Application Support/typora-user-images/image-20191130223557501.png" alt="image-20191130223557501" style="zoom:50%;" />

According the answer, RANSAC produces larger errors,  According the exercise 2.2, I know errors is influenced by $\zeta$. when the algorithm is Brute force, x's answer is influenced by more $\zeta$'s parameters. Although their exception are same, but bacause sample's number, so RANSAC's variance will be bigger.