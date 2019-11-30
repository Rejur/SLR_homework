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

the error is equal $||(A^TA)^{-1}A\zeta||/||x||$, Generally, when n = 1 and m = 1, then the question is to know $|(A^{-1}\zeta)|/|x| \le 1/100$, $E(\zeta)=\delta \sqrt{2/\pi}$,$E(A)=E(x)=\sqrt{2/\pi}$, so we can know $\delta \le \sqrt{2/\pi}/100$, the error's exception is less than $1\%$.

##### Exercise 2.2:

