clc; 
clearvars; 
close all;

global w; % w i UZ musz¹ byæ zdefiniowane i wype³nione w programie g³ównym
global UZ;
global wynik; % to samo wektor wynik

z_ogr = 1; %% 0 - bez ograniczeñ, 1 - z ograniczeniami

% poni¿sza linia to takie WooDoo aby zainicjalizowaæ wektory
% bez niej bêd¹ problemy !!!!
w=[]; UZ=[]; wynik=[]; x=[]; xw=[];

% Program g³ówny: 
% !!!!zadajemy czêstotliwoœæ i wymagane napiêcie

w(1) = 1;   UZ(1) = 1;
w(2) = 10;  UZ(2) = 1;
w(3) = 50;  UZ(3) = 1;
w(4) = 250; UZ(4) = 0.4 ;
w(5) = 1000;UZ(5) = 0.01;

% w(1) = 1;       UZ(1) = 1.155e-05;
% w(2) = 10;      UZ(2) = 0.001155;
% w(3) = 25;      UZ(3) = 0.007215;
% w(4) = 50;      UZ(4) = 0.02882 ;
% w(5) = 75;      UZ(5) = 0.06465;
% w(6) = 100;     UZ(6) = 0.1142;
% w(7) = 250;     UZ(7) = 0.5744;
% w(8) = 500;     UZ(8) = 0.9334;
% w(9) = 750;     UZ(9) = 0.9825;
% w(10) = 1000;   UZ(10) = 0.9929;

!!!! definiujemy wartoœci pocz¹tkowe
R1=4.3e3; %to x1 
R2=4.3e3; %to x2
R3=9.1e3; %to x3
C1=0.33e-6; %to x4
C2=0.047e-6; %to x5

% R1 = 3.9e3;
% R2 = 7.5e3;
% C1 = 0.1e-6;
% C2 = 0.1e-6;

x0(1) = 4.3e3/1e3; 
x0(2) = 4.3e3/1e3; 
x0(3) = 9.1e3/1e3;
% x0(1) = 4.3e3*1e-3; 
% x0(2) = 4.3e3*1e-3; 
% x0(3) = 9.1e3*1e-3;
x0(4) = 0.33e-6*1e6; 
x0(5) = 0.047e-6*1e6;

% x0(1) = 3.9e3*1e-3; 
% x0(2) = 7.5e3*1e-3; 
% x0(3) = 0.1e-6*1e6;
% x0(4) = 0.1e-6*1e6;

a=orys(x0,'b-','Przed Opt'); % rysujemy przebieg dla wartoœci pocz¹tkowych
hold on; %% aby kolejne wyniki drukowac w tym samym oknie

if z_ogr == 0 %% ktora metoda ???
    % optymalizujemy funkcjê z pliku ofun
    options=optimset('fminunc');
    % bez ograniczeñ
    [xw,fval,exitflag,output]=fminunc('ofun',x0,options)
else
    
    % z ograniczeniami lb <= x <= ub
    nx = size(x0);
    nx = nx(2); % ilosc elementow wektora x0

    for i=1:nx
        lb(i) = 1e-9; % dolne ogr na x 
        ub(i) = 1e10; % górne ogr na x
    end

    options=optimset('fmincon');
    [xw,fval,exitflag,output]=fmincon('ofun',x0,[],[],[],[],lb,ub);
end

a=orys(xw,'r:', 'PoOpt') % wykres po optymalizacji
semilogx(w, UZ, '+r', 'DisplayName', 'Zadane punkty');
hold off;

