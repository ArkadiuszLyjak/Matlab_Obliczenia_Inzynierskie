close all;
clc; 
clearvars;

zeta_10 = 1-2i;
zeta_12 = 0.5+1i;
zeta_13 = 2+4i;
zeta_30 = 0.5-3i;
zeta_34 = 1.5 + 2i;
zeta_40 = 2 - 3i;

y_10 = 1/zeta_10;
y_12 = 1/zeta_12;
y_13 = 1/zeta_13;
y_30 = 1/zeta_30;
y_34 = 1/zeta_34;
y_40 = 1/zeta_40;

y_11 = y_10 + y_13 + y_12;
y_22 = y_12;
y_33 = y_13 + y_34 + y_30;
y_44 =  y_34 + y_40;

Y = [y_11 -y_12 -y_13 0
    -y_12 y_22 0 0
    -y_13 0 y_33 -y_34
    0 0 -y_34 y_44];

