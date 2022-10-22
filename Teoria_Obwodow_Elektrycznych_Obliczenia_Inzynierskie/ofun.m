function fo=ofun(x)
global w; % w i UZ musz¹ byæ zdefiniowane i wype³nione w programie g³ównym
global UZ; 
global wynik; % tu siedz¹ wartoœci napiêcia dla zadanych f - czestotl. 

% R1=x(1); 
% R2=x(2); 
% R3=x(3); 
% C1=x(4); 
% C2=x(5);

% x0(1) = 3.9e3\1e-3;
% x0(2) = 7.5e3\1e-3;
% x0(3) = 0.1e-6\1e+6;
% x0(4) = 0.1e-6\1e+6;

R1=x0(1)*1e3; 
R2=x0(2)*1e3; 
% R3=x0(3); 
C1=x0(3)/1e6; 
C2=x0(4)/1e6;

% %Licznik transmitancji - macierz 
% L= [-(1/(R1*R3*C1*C2))] ;
% %Mianownik transmitancji - macierz 
% M= [1 (1/C1)*(1/R1+1/R2+1/R3) 1/(R2*R3*C1*C2)] ;

%Licznik transmitancji - macierz

l_0 = [1 0 0];
L = l_0;

%Mianownik transmitancji - macierz

m_0 = 1/(R1*R2*C1*C2);
m_1 = (1/(R2*C1))+(1/(R2*C2));
m_2 = 1;
M = [m_2 m_1 m_0];

f = 0; % wartoœæ pocz¹tkowa funkcji
s = size(w); % rozmiary wektora w
zakres=s(2); % rozmiar zadanego wektora 
a = 0; % zmienna pomocnicza

for i=1:zakres;
    w(i) = w(i) * 2 * pi; % zamieniamy f na OMEGA
end

H=freqs(L,M,w);
wynik=abs(H); % wyniki w zadanych punktach

for i=1:zakres;
    a = UZ(i) - wynik(i); % zadane MINUS obliczone
    f = f + a * a; % funkcja to suma kwadratów
    w(i) = w(i) / (2*pi); % zmieniamy OMEGA na f
end
    fo=f
end  % koniec funkcji

