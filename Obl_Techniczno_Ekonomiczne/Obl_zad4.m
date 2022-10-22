close all;
clc; 
clearvars;

        % | FROM | TO | R | X |
        % | bus  | bus| pu|pu |
    Dane=[  1     0    1    -2
            1     2    0.5   1
            1     3    2     4
            3     0    0.5  -3
            3     4    1.5   2
            4     0    2    -3];
        
%podzielenie na poszczególne wektory

wp = Dane(:,1);
wk = Dane(:,2);
r = Dane(:,3);
x = Dane(:,4);

Z = r+1i*x;
Y = 1./Z;

%ng-licbz aga³êzi nw-liczba wêz³ów

licz_gal = length(wp);
licz_wez = max(max(wp),max(wk));
Y = zeros(licz_wez,licz_wez);

%uzupe³niamy elementy Y poza digonalami
for j = 1:licz_wez
    for i = 1:licz_gal
        if wp(i) ~= 0 && wk(i) ~= 0
            Y(wp(i), wk(i)) = -Y(i);
           Y(wp(i), wk(i)) = -Y(i);
        end
    end
end
