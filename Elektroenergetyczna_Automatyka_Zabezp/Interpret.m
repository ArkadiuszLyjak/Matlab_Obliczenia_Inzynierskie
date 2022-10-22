clc;
clearvars;
close all;

syms I_L1 I_L2 I_L3 I_0 I_1 I_2
syms a a2

% a = exp(1i*(2*pi/3));
% a2 = exp(-1i*(2*pi/3));

I_3ph = [I_L1; I_L2; I_L3];
I_012 = [I_0; I_1; I_2];
S_matrix = [1 1 1; 1 a2 a; 1 a a2];
inv_S_matrix = (1/3) * [1 1 1; 1 a a2; 1 a2 a];

I_3ph = S_matrix * I_012;
fprintf('%s %s\n', 'I_L1 = ', I_3ph(1,1));
fprintf('%s %s\n','I_L2 = ', I_3ph(2,1));
fprintf('%s %s\n', 'I_L3 = ', I_3ph(3,1));

a_num = exp(1i*(2*pi/3));
% fprintf('a_num = \t%2.4f\t% 2.4fi\n', real(a_num), imag(a_num));
R = abs(a_num);
theta = angle(a_num);
z = R*exp(1i*theta);

a2_num = exp(-1i*(2*pi/3));
% fprintf('a2_num = \t%2.4f\t% 2.4fi\n', real(a2_num), imag(a2_num));
R2 = abs(a2_num);
theta2 = angle(a2_num);
z2 = R2*exp(1i*theta2);