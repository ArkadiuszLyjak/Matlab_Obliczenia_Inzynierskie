clc; clear; close all;
format shortG ,format compact

f = 50;
w = 2 * pi * f;
J1 = 1 -1i; J2 = 2 + 5*1i; J3 = 4 - 5*1i;
R1 = 1e3; R2 = 1e4; R3 = 1e3;
C1 = 1e-4; C2 = 1e-4; C4 = 1e-5;
L1 = 1e-4; L3 = 1e-3;

Z10 = R1 + 1i * w * L1;
Z02 = 1 / (1i * w * C4);
Z23 = R2 - 1i;
Z03 = R3 + 1i * w * L3;

Y11 = 1 / Z10;
Y22 = 1 / Z02 + 1/Z23;
Y33 = 1 / Z23 + 1 / Z03;
Y12 = 0; Y13 = 0;
Y23 = -1 / Z23;

Y = [Y11 Y12 Y13; Y12 Y22 Y23; Y13 Y23 Y33];
Jz = [ J1 + J2, -J2 - J3, J3 ];

V = Jz / Y;
v1 = V(1); 
v2 = V(2);
v3 = V(3);

U10 = v1 - 0;
I10 = U10 / Z10;
BW1 = J1 + J2 - I10
U02 = 0 - v2;
U23 = v2 - v3;
I02 = U02 / Z02;
I23 = U23 / Z23;
BW2 = -J2 - I23 + I02 - J3
I03 = -v3 / Z03;
BW3 = I23 + I03 + J3

% Bilans energetyczny - Zasada Tellegena
MOC_ZR = (0 - v1)  * conj(J1)
MOC_ZR_ = MOC_ZR + (v2 - v1) * conj(J2)
MOC_ZR = MOC_ZR + (v2 - v3) * conj(J3)
MOC_GAL = U10 * conj(I10)
MOC_GAL = MOC_GAL + v2 * conj(I02)
MOC_GAL = MOC_GAL + U23 * conj(I23)
MOC_GAL = MOC_GAL + v3 * conj(I03)