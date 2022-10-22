function [p,L] = Gauss_F_Interpollagrange(x,y)
% x = [x0,x1,...,xN], y = [y0,y1,...yN] - dane wejœcuiwe 
% p - wspolczynniki wielomianu Lagrange'a stopnia n
% L = wspolczynniki Lagrange'a
N = length(x) - 1;
p = 0;
for m=1:N+1
    P = 1;
    for k=1:N+1% dla kazdego punkctu danych licz wsp.
        if k ~= m
            P=conv(P,[1 -x(k)])/(x(m) - x(k)); % wymna¿anie kolejnych par ilorazów
        end % end if
    end %end  k
L(m,:) = P;   %wspolczynniki wielomianowe Lagrange'a
p = p + y(m) * P; %wielomian Lagrange'a
end %end m