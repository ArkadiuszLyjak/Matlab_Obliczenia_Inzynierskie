%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc;   

% Rozwiazujemy ukl. rownan postaci A*x=b
A = [
    1 0 -1 0 0 0 0
    -1 1 1 0 0 0 0
    0 -1 2 -1 0 0 0
    0 -1 0 2 0 1 0
    0 -1 -1 0 2 1 1
    0 0 1 -1 0 2 -1 
    0 0 0 -1 1 -1 2
    ];
b = [0 0 0 0 0 20 0]';

N = 500;
tol=10e-5;
err = ones(1,N);

%Jacobi
S = diag(diag(A));
T = S - A;
x = zeros(size(b));

for k=1:N,
        x = S\(T*x+b);
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <= tol),
                disp('Jacobi k='),disp(k);
                break;
        end
end

subplot(3,1,1)
semilogy([1:N],err);
%SOR
D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);
x = zeros(size(b));
err = ones(1,N);
w=1.05;

for k=1:N,
        x = inv(D+w*L)*((1-w)*D-w*U)*x+w*inv(D+w*L)*b;
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <= tol),
                disp('SOR k='),disp(k);
                break;
        end
end

subplot(3,1,2)
semilogy([1:N],err);

poczatek=0.7;
koniec=1.2;
krok=0.05;
petla=(koniec-poczatek)/krok +1;
ro=1;
optw=1;
w=poczatek;
osx=poczatek;

for k=2:petla+1,
    M=inv(D+w*L)*((1-w)*D-w*U);
    ro(k)=max(abs(eig(M)));
    osx(k)=w;
    if (ro(k)<ro(k-1)),
        optw=w;
    end
    w=w+krok;
end

disp('optymalna w='),disp(optw);
subplot(3,1,3)
plot(osx,ro)
