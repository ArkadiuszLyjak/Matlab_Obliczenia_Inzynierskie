clc;
clearvars;
close all;

syms w m n
syms a a2
syms dU_L1 dU_L2 dU_L3
syms I_L1 I_L2 I_L3
syms I_0 I_1 I_2 
syms U_0 U_1 U_2 
syms Z_0 Z_1 Z_2

I_012 = [I_0; I_1; I_2];
dU_012 = [U_0; U_1; U_2];
Z_012 = [Z_0; Z_1; Z_2];

% Zamienione musi byc na liczbe przed pierwszym wystapieniem. 
% Inaczej nalezaloby uzyc funkcji zamieniajacej zmienne.

a = exp(1i*(2*pi/3));
a2 = exp(-1i*(2*pi/3));

if((a + a2 + 1) <= 1e-8)
    fprintf("a + a2 + 1 = %d", a + a2 + 1);
end

S_matrix = [1 1 1; 1 a2 a; 1 a a2];
inv_S_matrix = (1/3) * [1 1 1; 1 a a2; 1 a2 a];
dU_3ph = [dU_L1; dU_L2; dU_L3];

n = m;

Z_3ph = [w m n; n w m; m n w];
I_3ph = [I_L1; I_L2; I_L3];

dU_3ph = Z_3ph * I_3ph;
I_3ph = S_matrix * I_012;
dU_3ph = S_matrix * dU_012;


% Uproszcznie macierzy impedancji.

Z_012 = (inv_S_matrix * Z_3ph * S_matrix)
simplify(Z_012)