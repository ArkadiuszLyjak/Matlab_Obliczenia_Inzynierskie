clc; clear; close all;

%% Dane modelu 
UN=230;     % V – napiêcie wartoœæ skuteczna 
f=50;       % Hz – czêstotliwoœæ napiêcia  
fi=0;       % rad – faza pocz¹tkowa napiêcia  

%% Parametry modelu 
T=1/f;          % s okres  
Um=UN*2^0.5;    % V amplituda napiêcia 
omega=2*pi*f;   % rad/s prêdkoœæ k¹towa 

%% Parametry symulacji 
tp=0;       % s Czas pocz¹tku symulacji 
tk=T;       % s Czas koñca symulacji 
dtmax=1e-4; % s Maksymalny krok czasu 
dtmin=1e-5; % s Minimalny krok czasu 
dtpocz=1e-4;% s Pocz¹tkowy krok czasu 

%% Uruchomienie modelu symulacyjnego, zmienne z wynikami obliczeñ 
fcn=1; %1 model z blokiem FCn rys 14, 0 bez Fcn, rys 13 

if fcn==1;
    sim('cw1_sim_fcn'); %Wywo³anie modelu sym. zapisanego w pliku cwf1.mdl 
else
    sim('cw1_simulink'); 
end   %Wywo³anie modelu sym. zapisanego w pliku cw1.mdl

t=ws(:,1);             %Wektor chwil czasu 
u=ws(:,2);             %Wektor wartoœci napiêæ 
psi=ws(:,3);           %Wektor wartoœci strumieni 

%% Przygotowanie okien na wykresy i ustawienie wielkoœci czcionki 
% close all %zamkniêcie okien graficznych 
fosiz=9;      %wielkoœæ fontów na wykresie nale¿y dobraæ doœwiadczalnie 
set(0, 'DefaultAxesFontSize', fosiz); 
set(0,'defaultfigurecolor','w'); 
ekran = get(0, 'ScreenSize');            %odczytanie rozdzielczoœci ekranu 
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
legend([h1,h2],'Napiêcie, V','Strumieñ przeskalowany, Wb',1);%opis linii 
set(gca,'position',[0.1 0.07 0.85 0.9]); 
xlabel('Czas, s');ylabel('Wyniki symulacji');grid 
 
%% Trajektoria przebiegów 
figure('position',oknop,'name','Zale¿noœæ Psi(u)','numberTitle','off'); 
plot(u, psi,'b',[0 u(1)],[0,psi(1)],':r');hold  on 
h1=plot(u(1),psi(1),'.r','markersize',12);hold off 
legend(h1, 'Punkt pocz¹tkowy trajektorii') 
xlabel('Napiêcie, V'); ylabel('Strumieñ przeskalowany, Vs '); 
set(gca,'dataaspectratio',[1 1 1]); grid 

pause(3);
close all;