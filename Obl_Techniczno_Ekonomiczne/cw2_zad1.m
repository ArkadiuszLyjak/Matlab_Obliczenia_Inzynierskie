close all;
clc; 
clearvars;

f=@(x) 0.25*x^4 + 0.5*x^3 - 0.5*x^2 +2*x - 10;

x0 = 0;
x1 = 2.5;
i = 0;
alfa = 2;
N = 50;
f0=f(x0);
f1=f(x1);

msg= 'Licznik iteracji > N';

for i=1:N
    
if i>N
        error(msg)
end

if f1==f0
    Przedzial = [x0,x1]
end

if f1>f0
    x1=(-1)*x1;
        if f1>=f0
            Przedzial = [x1,(-1)*x1]
        end
end
    

x_st=alfa^(i-1)*x1;
x_nowy=alfa^(i)*x1;
x_seq=alfa^(i+1)*x1;

if f(x_st)<=f(x_nowy)
    break;
end


if x_st < x_seq
    Przedzial = [x_st,x_seq]
else
    Przedzial = [x_seq,x_st]
end
i=i+1;
end

ezplot(f,[-5,4])
hold on
grid on