clc; clear; close all;

%% Dane modelu 
UN=230;     % V � napi�cie warto�� skuteczna 
f=50;       % Hz � cz�stotliwo�� napi�cia  
fi=0;       % rad � faza pocz�tkowa napi�cia  

%% Parametry modelu 
T=1/f;          % s okres  
Um=UN*2^0.5;    % V amplituda napi�cia 
omega=2*pi*f;   % rad/s pr�dko�� k�towa 

%% Parametry symulacji 
tp=0;       % s Czas pocz�tku symulacji 
tk=T;       % s Czas ko�ca symulacji 
dtmax=1e-4; % s Maksymalny krok czasu 
dtmin=1e-5; % s Minimalny krok czasu 
dtpocz=1e-4;% s Pocz�tkowy krok czasu 

%% Uruchomienie modelu symulacyjnego, zmienne z wynikami oblicze� 
fcn=1; %1 model z blokiem FCn rys 14, 0 bez Fcn, rys 13 

if fcn==1;
    sim('cw1_sim_fcn'); %Wywo�anie modelu sym. zapisanego w pliku cwf1.mdl 
else
    sim('cw1_simulink'); 
end   %Wywo�anie modelu sym. zapisanego w pliku cw1.mdl

t=ws(:,1);             %Wektor chwil czasu 
u=ws(:,2);             %Wektor warto�ci napi�� 
psi=ws(:,3);           %Wektor warto�ci strumieni 

%% Przygotowanie okien na wykresy i ustawienie wielko�ci czcionki 
% close all %zamkni�cie okien graficznych 
fosiz=9;      %wielko�� font�w na wykresie nale�y dobra� do�wiadczalnie 
set(0, 'DefaultAxesFontSize', fosiz); 
set(0,'defaultfigurecolor','w'); 
ekran = get(0, 'ScreenSize');            %odczytanie rozdzielczo�ci ekranu 
szer = ekran(3);wys = ekran(4); 
oknol=[0 0.05*wys szer/2 0.85*wys]; %parametry okna z lewej strony ekranu 
oknop=[szer/2 0.05*wys szer/2 0.85*wys]; %parametry okna z prawej strony

%% Wykres w funkcji czasu 
figure('position',oknol,'name', 'Wyniki symulacji w funkcji czasu','numberTitle','off'); 
plot(t, u,'r', t, psi,'b') 
hold on 
h1=plot(t(10:20:end),u(10:20:end),'o',... 
    'MarkerEdgeColor','r','MarkerFaceColor','w'); 
h2=plot(t(10:20:end),psi(10:20:end),'s',... 
    'MarkerEdgeColor','b','MarkerFaceColor','w'); 
hold off 
legend([h1,h2],'Napi�cie, V','Strumie� przeskalowany, Wb',1);%opis linii 
set(gca,'position',[0.1 0.07 0.85 0.9]); 
xlabel('Czas, s');ylabel('Wyniki symulacji');grid 
 
%% Trajektoria przebieg�w 
figure('position',oknop,'name','Zale�no�� Psi(u)','numberTitle','off'); 
plot(u, psi,'b',[0 u(1)],[0,psi(1)],':r');hold  on 
h1=plot(u(1),psi(1),'.r','markersize',12);hold off 
legend(h1, 'Punkt pocz�tkowy trajektorii') 
xlabel('Napi�cie, V'); ylabel('Strumie� przeskalowany, Vs '); 
set(gca,'dataaspectratio',[1 1 1]); grid 

pause(3);
close all;