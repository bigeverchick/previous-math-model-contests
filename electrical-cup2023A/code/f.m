function  xprim=f(t,x)
xprim=[(8e3/1.1e6)+(-1/(1.1e6*1.2e-3))*(x(1)-x(2));(1/(1.86e8*1.2e-3))*(x(1)-x(2))-(1/(9.2e-3*1.86e8)*(x(2)+0))];