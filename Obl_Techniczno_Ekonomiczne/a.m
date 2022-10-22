function [a,b] = eksp(f,Nmax,x0,x1,L)
i=1;
x(i)=x0;
x(i+1)=x1;
if f(x(i+1)) == f(x(i))
a=x(i);
b=x(i+1);
return
end
if f(x(i+1)) > f(x(i))
x(i+1)=-x(i+1);
if f(x(i+1)) >= f(x(i))
a = x(i+1);
b = -x(i+1);
return
end
end
for i = 1:Nmax
x(i+2) = L^i*x(i+1);
if f(x(i+1)) <= f(x(i+2))
break
end
end
if x(i) < x(i+2)
a = x(i);
b = x(i+2);
return
end
a = x(i+2);
b = x(i);
return
end

