clc; clear; close all;
%% 1.1.Ustalenie koloru okna, zamkni�cie okien graficznych 
set(0,'defaultfigurecolor','w'); 
clear all %usuniecie wszystkich zmiennych z przestrzeni roboczej Matlaba 
close all %zamkni�cie wszystkich okien graficznych 
 
%% 1.2.Dane uk�ad�w elektrycznych 
U=5;    %V Napi�cie 
%W uk�adzie nieliniowym i=a*psi+b*psi^3 i - pr�d, psi - strumie� skojarzony 
a=1;    % wsp�czynnik 
b=1;    % wsp�czynnik 
R=0.5;  % Ohm Rezystancja 
L=0.2;  % H Indukcyjno�� obwodu liniowego 
ep=0.1; % % odchy�ka od warto�ci ustalonej pr�du w procentach pr ustalonego 
  
%% 1.3.Obliczenia w stanie ustalonym 
%W stanie ustalonym strumienie i pr�dy w uk�adzie liniowym i nieliniowym s� 
% takie same  
iz=U/R;          %Pr�d w stanie ustalonym 
psz=L*iz;        %Strumie� w st. ustalonym 
epsi=iz*ep/100;  % A odchy�ka od warto�ci ustalonej pr�du w A 
  
%% 1.4.Parametry symulacji i bloku napi�cia 
tp=-0.1;        %Pocz�tek symulacji 
tu=0;           %Pocz�tek za��czenia napi�cia 
T=L/R;          %Sta�a czasowa uk�adu liniowego 
tk=round(tu+8*T); %Koniec symulacji 
dtmin=1e-2*T;   %minimalny krok czasu 
dtmax=2*dtmin;  %mksymalny krok czasu 