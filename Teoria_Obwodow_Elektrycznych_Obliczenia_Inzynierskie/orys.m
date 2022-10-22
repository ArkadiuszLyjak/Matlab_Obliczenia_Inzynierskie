function f=orys(xr,parLinii,opisWykr)
global w; % w i UZ musz� by� zdefiniowane i wype�nione w programie g��wnym
global UZ; 
global wynik; % tu siedz� warto�ci napi�cia dla zadanych f - czestotl. 

% wektor w bedzie mial wartosci od wPocz do wKonc
% wPocz = 0.01;
% wKonc = 1000;
wPocz = 1;
wKonc = 1000;
ilePunktow = 10000;

% zapamietujemy aktualne warto�ci wektora w zawierajace cz�stotl
wTmp = w;
uzTmp = UZ; % oraz wektor UZ zawieraj�cy zadane warto�ci napi�cia
krok = (wKonc-wPocz)/ilePunktow;

for i=1:ilePunktow;
   w(i) = wPocz + krok * i;
   UZ(i) = 1; % oboj�tna warto��
end

fTmp = ofun(xr); %% obliczenia dla zadanych x i zadanych cz. w p�tli
semilogx(w, wynik, parLinii, 'DisplayName', opisWykr); % rysujemy przebieg

% czarna magia maj�ca na celu skr�cenie wektor�w
wynik=[0]; 
w=[0];
UZ=[0];
% koniec czarnej magii

w = wTmp; % odtwarzamy wektor w
UZ = uzTmp; % odtwarzamy wektor UZ

f = fTmp; %podstawiamy wyliczon� warto�� funkcji

end % koniec funkcji
