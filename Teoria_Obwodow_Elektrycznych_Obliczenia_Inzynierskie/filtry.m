% Przyk³adowy program:
%Dane
R1=4.3e3;
R2=4.3e3;
R3=9.1e3;
C1=0.33e-6;
C2=0.047e-6;
%Licznik transmitancji - macierz
l_0 = -1/(R1*R3*C1*C2)
L= [l_0]
%Mianownik transmitancji - macierz
m_0 = 1/(R2*R3*C1*C2);
m_1 = (1/C1)*(1/R1+1/R2+1/R3);
m_2 = 1
M= [m_2 m_1 m_0]
%Wykres
% pocz¹tek:krok:koniec
% wartosci mnoze przez 2*pi aby by³y zgodne z NAP-em
% bo w NAP-ie mamy czestotliwosc f
% w MATLAB-ie mamy OMEGA w
w=10*2*pi:0.1*2*pi:1000*2*pi;
H=freqs(L,M,w);
% polecenie rysowania wykresu
% semilogx ozncza, ze na osi X bedzie skala LOGARYTMICZNA
% w takiej skali rysuje sie wykresy czestotliwosciowe
% aby z w przejsc na f wystarczy podzieliæ przez 2*pi
semilogx((w/(2*pi)),abs(H),'b','DisplayName', 'Z MATLABA')