syms t n c1 c2 r1 r2 x0 y0 Pn Tout
[x,y] = dsolve('Dx =(8e3/1.1e6) + (-1/(1.1e6*1.2e-3))*(x-y)', 'Dy = (1/(1.86e8*1.2e-3))*(x-y)-(1/(9.2e-3*1.86e8)*(y))','x(0)=20','y(0)=15');  
[x2,y2] = dsolve('Dx2 = (-1/(1.1e6*1.2e-3))*(x2-y2)', 'Dy2 = (1/(1.86e8*1.2e-3))*(x2-y2)-(1/(9.2e-3*1.86e8)*(y2))','x2(0)=22','y2(0)=15');  

vpa(x);
vpa(x2);

t1 = solve(x == 22,t);
t2 = solve(x2 == 18,t);
b = [Pn;Tout/r2];
a = [-1/r1 1/r1;1/r1 -1/r1-1/r2];