close all;
clc; 
clearvars;

zeta_10 = 1-2i; % ga³¹Ÿ 1
zeta_12 = 0.5+1i; % ga³¹Ÿ 2
zeta_13 = 2+4i; % ga³¹Ÿ 3
zeta_30 = 0.5-3i; % ga³¹Ÿ 4
zeta_34 = 1.5 + 2i; % ga³¹Ÿ 5
zeta_40 = 2 - 3i; % ga³¹Ÿ 6

y_10 = 1/zeta_10;
y_12 = 1/zeta_12;
y_13 = 1/zeta_13;
y_30 = 1/zeta_30;
y_34 = 1/zeta_34;
y_40 = 1/zeta_40;

G = diag([y_10 y_12 y_13 y_30 y_34 y_40]);
K = [1 0 0 0 0 1
    -1 -1 -1 0 0 0
    0 1 0 0 0 0
    0 0 1 1 -1 0
    0 0 0 0 1 -1];

Y_ext = K*G*K';
Y_ext(1,:) = [];
Y_ext(:,1) = [];
Y = Y_ext;

