符号：选定的信用卡为 $i(1 \leq i \leq 100)$，阈值$j(1\le  j \le 10)$，$h_{ij}$对应i卡j阈值坏账率，$t_{ij}$对应i卡j阈值  通过率，总坏账率h，总通过率t，T、H代表通过率、坏账率组成的矩阵。  
贷款资金M，利息收入r，卡总数$i_{max} =100$，阈值总数$j_{max}=10$  
根据题目假设，M=100000，r=0.08  
收入：$Mrt(1-h)$   
损失：$Mth$  
最终收入：  
$
\begin{aligned}
 Mrt(1-h)-Mth \\
= Mrt-Mrth-Mth \\
= Mt(r-rh-h) \\
= Mt[r-(1+r)h] \\
= Mrt[1-\frac{1+r}{r}h] \\
\end{aligned}
$
  
由题意，M、r为常数。由于在问题中常数项取值对最大值的$i,j$不影响，可省略部分常数，将题目简化为：求收益函数$f(t,h)=t(1-ah) $ 的最大值，其中$a= \frac{1+r}{r}$为常数给定值。  
针对问题1，由符号假设，$t_{ij}\in T,h_{ij}\in H.$因此原问题目标函数是关于$T,H,X$的函数。  
定义函数决策变量$x_{ij}\in\{1,0\}$，其中$x_{ij}$组成向量$x$。  $g_{ij} = f_{ij}x_{ij} = f(t_{ij},h_{ij})x_{ij}$，
目标函数$G=\sum_{i=1}^{100}\sum_{j=1}^{10}g_{ij}$ ，
可针对原问题建立优化模型如下：

$$
max: G(T,H,x)=\sum_{i=1}^{100}\sum_{j=1}^{10}x_{ij}f(t_{ij},h_{ij}) \\
s.t.
\left\{
\begin{aligned}
\sum_{j=1}^{10}x_{ij} \le1 &&(1-1) \\
\sum_{i=1}^{100}\sum_{j=1}^{10}x_{ij} = 1 &&(1-2)\\
\end{aligned}
\right.

$$
其中，
$x_{ij}=
\left\{
    \begin{aligned}
    0,  &&&第i卡第j阈值未被选中\\
    1,  &&&第i卡第j阈值被选中\\
    \end{aligned}
\right.
$

式(1-1)表示每个卡最多可取一个阈值，(1-2)表示100张卡中有一个阈值被选择。显然，(1-2)条件包含了(1-1)的情况，也就是说约束条件可以省略(1-1).

因为$x_{ij}$是0-1变量，所以$\forall i,j,有x_{ij}^{2}=x_{ij} .$  
$$
\begin{aligned}
g_{ij}= x_{ij}f(t_{ij},h_{ij})  = x_{ij}^{2}f(t_{ij},h_{ij}),\\ 
G=\sum_{i=1}^{100}\sum_{j=1}^{10}x_{ij}^{2}f(t_{ij},h_{ij})&&&&&(1-3)\\
\end{aligned}
$$
  
这是一个组合优化问题。可通过以下步骤，将目标函数转化为QUBO形式$max:x^{T}Qx$  
$x_{ij}$组成$100\times 10=1000$维的一元列向量$x=(0,\dots,1,\dots,0)$，可将编号$i,j$进行降维处理至$x_{k}(1\le k \le 1000)$即只使用一个值对$x$的约束，相关的转化方式为：
$$
i = \lceil \frac{k}{10}\rceil\\
\left\{
\begin{aligned}
j = 1&&&\cdots k是10的倍数\\
j=k &\mod  10 &&\cdots k不是10的倍数
\end{aligned}
\right.
$$
通过查阅文献知道，根据约束条件可定义惩罚函数，将问题转化为无约束优化。
$$
\begin{aligned}
penalty = -P(\sum_{k=1}^{1000}x_{k} -1)^{2}
\end{aligned}
$$
其中，P为一个相对目标函数可能取值的一个极大的数，若不满足约束条件，惩罚函数会极大地减小函数值，避免此解被选中为最优解，因此对目标函数起到约束作用。  
矩阵$Q=(f_{k})_{1000}=(f_{ij})_{1000}$，由于(1-3)只包含$x_{ij}$相关的平方项，因此Q矩阵是一个$1000\times1000$的对角阵，$Q_{k} = f(t_{k},h_{k})=t_{k}(1-ah_{k})$  

综上所述，可对原优化问题进行QUBO建模：
$$
\begin{aligned}
max:x^{T}Qx-P(\sum_{i=1}^{1000}x_{k} -1)^{2}\\
\end{aligned}
$$
$Q=diag(t_{1}(1-ah_{1}),t_{2}(1-ah_{2}),\dots,t_{1000}(1-ah_{1000})).$ 

罚系数P的选取。
