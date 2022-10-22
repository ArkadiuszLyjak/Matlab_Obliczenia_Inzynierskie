clc; clear; close all;
%% 1.1.Ustalenie koloru okna, zamkniêcie okien graficznych 
set(0,'defaultfigurecolor','w'); 
clear all %usuniecie wszystkich zmiennych z przestrzeni roboczej Matlaba 
close all %zamkniêcie wszystkich okien graficznych 
 
%% 1.2.Dane uk³adów elektrycznych 
U=5;    %V Napiêcie 
%W uk³adzie nieliniowym i=a*psi+b*psi^3 i - pr¹d, psi - strumieñ skojarzony 
a=1;    % wspó³czynnik 
b=1;    % wspó³czynnik 
R=0.5;  % Ohm Rezystancja 
L=0.2;  % H Indukcyjnoœæ obwodu liniowego 
ep=0.1; % % odchy³ka od wartoœci ustalonej pr¹du w procentach pr ustalonego 
  
%% 1.3.Obliczenia w stanie ustalonym 
%W stanie ustalonym strumienie i pr¹dy w uk³adzie liniowym i nieliniowym s¹ 
% takie same  
iz=U/R;          %Pr¹d w stanie ustalonym 
psz=L*iz;        %Strumieñ w st. ustalonym 
epsi=iz*ep/100;  % A odchy³ka od wartoœci ustalonej pr¹du w A 
  
%% 1.4.Parametry symulacji i bloku napiêcia 
tp=-0.1;        %Pocz¹tek symulacji 
tu=0;           %Pocz¹tek za³¹czenia napiêcia 
T=L/R;          %Sta³a czasowa uk³adu liniowego 
tk=round(tu+8*T); %Koniec symulacji 
dtmin=1e-2*T;   %minimalny krok czasu 
dtmax=2*dtmin;  %mksymalny krok czasu 