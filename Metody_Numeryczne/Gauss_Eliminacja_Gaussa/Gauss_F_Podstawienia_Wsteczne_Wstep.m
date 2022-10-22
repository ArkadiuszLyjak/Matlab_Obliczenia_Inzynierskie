function X = Gauss_F_Podstawienia_Wsteczne_Wstep(U,Y)
% podstawienie wsteczne wst�puj�ce
% U macierz U rozk�adu LU
% Y - wektor Y  rozwi�zania posredniego


Uy = [U Y]; % macierz rozszerzona

% Rozmiar macierzy
[nrow,ncol] = size(Uy) ;

% Przygotowanie macierzy dla podstawienia wstecznego zst�puj�cego 
% przeliczenie macierzy do postaci z przek�tna diagonaln�
for n = 1:nrow
s = Uy(n,n);
Uy(n,1:ncol) = Uy(n,1:ncol)/s;
end
%
X = zeros(1,nrow)';% reserwacja pami�ci
X(nrow) = Uy(nrow,ncol) ;  % pierwsza niewiadoma

% podstawienie wsteczne  zst�puj�ce
for n = nrow-1:-1:1
w = Uy(n,1:ncol-1)*X;
X(n) = Uy(n,ncol)-w;
end