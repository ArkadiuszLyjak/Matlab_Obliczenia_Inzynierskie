clc; 
clearvars; 
close all;

Jacobi = 1;
SOR = 1;

%% Rozwiazujemy ukl. rownan postaci A*x = b

A = [
    1   0   -1  0  0  0  0
    -1  1    1  0  0  0  0
    0  -1    2 -1  0  0  0
    0  -1    0  2  0  1  0
    0  -1   -1  0  2  1  1
    0   0    1 -1  0  2  -1 
    0   0    0 -1  1  -1  2
    ];
b = [0 0 0 0 0 20 0]';

N = 500;
tol = 10e-5;
err = ones(1,N);

%% ##############################
%% ######### Jacobi #############
%% ##############################

if Jacobi  ==  1

S = diag(diag(A)) % Wybiera elem. diag. i reszte uzup. zerami
T = S - A
x = zeros(size(b))

for k = 1:N,
        x = S\(T*x + b);
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <=  tol),
                disp('Jacobi k = '), disp(k);
                break;
        end
end

semilogy([1:N],err);
title('Jacobi')
xlabel('Liczba iteracji')

end

%% ##############################
%% ######### Metoda SOR #########
%% ##############################

if SOR  ==  1
    
D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);
x = zeros(size(b));
err = ones(1,N);
w = 1.05;

for k = 1:N,
        x = inv(D + w*L)*((1-w)*D-w*U)*x + w*inv(D + w*L)*b;
        r = b-A*x;
        err(k) = norm(r);
        if (err(k) <=  tol),
                disp('SOR k = '),disp(k);
                break;
        end
end

semilogy([1:N],err);
title('SOR')
xlabel('Liczba iteracji')

% Wyliczenie wspolczynika relaksacji dla metody SOR.

poczatek_przedzialu = 0.3;
koniec_przedzialu = 1.2;
krok_szukania = 0.05;
petlowanie = ((koniec_przedzialu - poczatek_przedzialu)/krok_szukania)  +  1;
ro = 1;
optym_w = 1;
w = poczatek_przedzialu;
osx = poczatek_przedzialu;

for k = 2:petlowanie + 1,
    M = inv(D + w*L) * ((1-w) * D-w*U);
    ro(k) = max(abs(eig(M)));
    osx(k) = w;
    if (ro(k)<ro(k-1)),
        optym_w = w;
    end
    w = w + krok_szukania;
end

disp('optymalna w = '), disp(optym_w);
plot(osx,ro)
title('Wsp. relaksacji.')
end
