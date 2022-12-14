function X = Gauss_F_Podstawienia_Wsteczne_Wstep(U,Y)
% podstawienie wsteczne wstępujące
% U macierz U rozkładu LU
% Y - wektor Y  rozwiązania posredniego


Uy = [U Y]; % macierz rozszerzona

% Rozmiar macierzy
[nrow,ncol] = size(Uy) ;

% Przygotowanie macierzy dla podstawienia wstecznego zstępującego 
% przeliczenie macierzy do postaci z przekątna diagonalną
for n = 1:nrow
s = Uy(n,n);
Uy(n,1:ncol) = Uy(n,1:ncol)/s;
end
%
X = zeros(1,nrow)';% reserwacja pamięci
X(nrow) = Uy(nrow,ncol) ;  % pierwsza niewiadoma

% podstawienie wsteczne  zstępujące
for n = nrow-1:-1:1
w = Uy(n,1:ncol-1)*X;
X(n) = Uy(n,ncol)-w;
end