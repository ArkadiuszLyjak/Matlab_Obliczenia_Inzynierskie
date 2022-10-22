% Eliminacja Gaussa.

clc; clear; close all;
format shortG ,format compact

I   = 10;   %[A], 
E1  = 5;   %[V],
E2  = 8;   %[V], 
R1  = 5;   %[?],
R2  = 5;   %[?],
R3  = 3;   %[?],
R4  = 7;   %[?],
R5  = 2;   %[?],
% Wyznaczenie postaci macierzowej
% I1 + I4 = I                  | I1 + I4 = I                 | 1   0   0   1    0  ||I1|  |I  |   
% I3 + I4 = I5                 | I3 + I4 - I5 =  0             | 0   0   1   1   -1  ||I2|  |0  |     
% I2 + I3 = I1                 |-I1 + I2 + I3 = 0            |-1   1   1   0    0  ||I3| =  |0  |                       
% R1 I1 + R3 I3 - R4 I4 = E1   | R1 I1 + R2 I3 - R4 I4 = E1  |R1   0   R3 -R4   0  ||I4|  |E1 |           
% R2 I2 - R3 I3 - R5 I5 = -E2  | R2 I2 - R3 I3 - R5 I5 = -E2 | 0   R2 -R3  0   -R5 ||I5|  |-E2|  

% A- macierz nxn
A = [1 0 0 1 0;
   0 0 1 1 -1;
   -1 1 1 0 0;
   R1 0 R3 -R4 0;
   0 R2 -R3 0 -R5];
% Wektor nx1
 b = [I 0 0 E1 -E2]';  %  b -> I  


 
  AB = [A b]; % rozszerzenie macierzy
 [nrow,ncol] = size(AB);% Wymiar macierzy
 
 
 % Eliminacja Gussa
 
% Pêtla g³ówna
 for k = 1:nrow-1
      % warunek wyboru elementu g³ównego
if AB(k,k) == 0 % jeœli element g³ówny ==0
    
    elg = AB(:,k); % pobierz kolumnê   
    pos = find(elg(k:end) == max(abs(elg(k:end))))+k-1; % znajdznaj wiêkszy bezwzglêdnie element i jego pozycje 
  
    temp1       = AB(k,:);    % zamieñ wiersze
    temp2       = AB(pos,:);
    AB(k,:)     = temp2;
    AB(pos,:)   = temp1;
end
 
 % dzielimy wx przez axx - jeden na g³ónej przek¹tnej
    AB(k,k:ncol) = AB(k,k:ncol)/AB(k,k);
 %odejmujemy od ca³ego drugiego wiersza wiersz k, pomno¿ony przez al,k
 for l = k+1:nrow
    AB(l,k:ncol) = AB(l,k:ncol)-AB(k,k:ncol)*AB(l,k);
 end
 
 end
% Ustaw ostatni element g³ówny na 1
s = AB(nrow,nrow);
AB(nrow,nrow:ncol) = AB(nrow,nrow:ncol)/s;
% Wyœwietl macierz
AB