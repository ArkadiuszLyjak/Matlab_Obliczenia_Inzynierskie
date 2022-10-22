%% Czyszczenie okna danych, zmiennych i zamykanie okien
clc; clear all; close all;okno=0.1;


% a=input('Amplituda A= ');
% %a0=input('Skladowa stala ');
% f=input('Czestotliwosc sygnalu ');
% licz_okr=input('Liczba okresow ');
% licz_pr=input('Liczba probek na okres');
a=10;
%a0=input('Skladowa stala ');
f=50;
licz_okr=1;
licz_pr=1024;

%%
t=linspace(0,(1/f),(licz_pr));
a0=0;
for i=1:(licz_okr)
	for j=1:(licz_pr)
		x(licz_pr*(i-1)+j)=a0+a*sin(2*pi*f*(t(j)+1/f*i));
	end
end
y=fft(x);
yabs=abs(y);
subplot(211)
dt=(size(x(:)));
tp=linspace(0,(1/f*licz_okr),dt(1));

%%
plot(tp,x),xlabel('Czas')
ylog=20*log10(yabs/(max(yabs)));
om=1:(licz_pr*licz_okr/2);
subplot(212),plot(om*f/licz_okr,ylog(om),'x')
hold on,plot(om*f/licz_okr,ylog(om)),hold off
xlabel('Czestotliwosc'), ylabel('Skala logarytmiczna')

