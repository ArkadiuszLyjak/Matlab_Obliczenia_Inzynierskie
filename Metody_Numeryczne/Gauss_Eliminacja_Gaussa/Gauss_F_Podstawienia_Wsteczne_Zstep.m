function Y = Gauss_F_Podstawienia_Wsteczne_Zstep(L,Pb)
% L- macierz L rozg³adu LU
% Pb wektor P*b - iloczyn macierzy permutacji i wektora prawych stron
%macierz rozrzerzona [L Pb]
  LPb = [L Pb] ;
% Rozmiar macierzy
  [nrow,ncol] = size(LPb) ; 
% Rezerwacja pamiêci dla rozwi¹zania Y
Y = zeros(1,nrow)';
Y(1) = LPb(1,ncol) ;  % pierwsza niewiadoma
% podstawienia wsteczne zstêpuj¹ce
for n = 2:nrow
w = LPb(n,1:ncol-1)*Y;
Y(n) = LPb(n,ncol)-w;
end
