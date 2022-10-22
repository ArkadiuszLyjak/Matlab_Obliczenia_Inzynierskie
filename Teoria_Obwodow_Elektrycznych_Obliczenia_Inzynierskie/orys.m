function f=orys(xr,parLinii,opisWykr)
global w; % w i UZ musz¹ byæ zdefiniowane i wype³nione w programie g³ównym
global UZ; 
global wynik; % tu siedz¹ wartoœci napiêcia dla zadanych f - czestotl. 

% wektor w bedzie mial wartosci od wPocz do wKonc
% wPocz = 0.01;
% wKonc = 1000;
wPocz = 1;
wKonc = 1000;
ilePunktow = 10000;

% zapamietujemy aktualne wartoœci wektora w zawierajace czêstotl
wTmp = w;
uzTmp = UZ; % oraz wektor UZ zawieraj¹cy zadane wartoœci napiêcia
krok = (wKonc-wPocz)/ilePunktow;

for i=1:ilePunktow;
   w(i) = wPocz + krok * i;
   UZ(i) = 1; % obojêtna wartoœæ
end

fTmp = ofun(xr); %% obliczenia dla zadanych x i zadanych cz. w pêtli
semilogx(w, wynik, parLinii, 'DisplayName', opisWykr); % rysujemy przebieg

% czarna magia maj¹ca na celu skrócenie wektorów
wynik=[0]; 
w=[0];
UZ=[0];
% koniec czarnej magii

w = wTmp; % odtwarzamy wektor w
UZ = uzTmp; % odtwarzamy wektor UZ

f = fTmp; %podstawiamy wyliczon¹ wartoœæ funkcji

end % koniec funkcji
