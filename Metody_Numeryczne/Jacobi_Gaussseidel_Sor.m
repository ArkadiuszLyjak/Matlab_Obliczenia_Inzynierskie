%function [A,b] = mac_2

close all;
clearvars;
clc;  

A = [ 
    3 -1 0 0 0 -1
    -1 3 -1 0 -1 0
    0 -1 3 -1 0 0
    0 0 -1 3 -1 0
    0 -1 0 -1 3 -1
    -1 0 0 0 -1 3
];

b = [0 0 0 0 0 20]';

N = 100;
tol=10e-5;

D = diag(diag(A));
L = tril(A);

%Jacobi
J = D - A;
x=zeros(size(b));
err = ones(1,N);
for k=1:N
        x = D\(J*x+b);
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <= tol)
                disp('Jacobi k='),disp(k);
                break;
        end
end
xJ = x
errJ = err;


%Gauss-Seidel
x=zeros(size(b));
err = ones(1,N);
G = L-A;
for k=1:N
        x = L\(G * x + b);
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <= tol)
                disp('Gauss-Seidel k='),disp(k);
                break;
        end
end
xG = x
errG = err;

%SOR
omega = 1.05;
LS = inv(D)*(-(L-D));
SR=1/omega * D * (eye(size(A))-omega*LS);
SOR=SR-A;
x=zeros(size(b));
err = ones(1,N);
for k=1:N
        x=SR\(SOR*x+b);
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <= tol)
                disp('SOR k='),disp(k);
                break;
        end
end
xS = x
errS = err;

semilogy([1:N],errJ, [1:N], errG, [1:N], errS);
xlabel('liczba iteracji')
ylabel('b³¹d')
legend('Jacobi', 'Gauss-Seidel', ['SOR, omega=',num2str(omega)]);