close all;
clc; 
clearvars;

% Funkcja TC: Q^3 - 10*Q^2 + 50*Q + 500

Q = [1.5:0.5:15]';
N = length(Q);
TC = zeros(N,1);
VC = zeros(N,1);
FC = zeros(N,1);
ATC = zeros(N,1);
AVC = zeros(N,1);
AFC = zeros(N,1);
MC = zeros(N,1);

for i=1:N
    TC(i) = Q(i)^3-10*Q(i)^2+50*Q(i)+500;
    VC(i) = Q(i)^3-10*Q(i)^2+50*Q(i);
    FC(i) = 500;
    ATC(i) = TC(i)/Q(i);
    AVC(i) = VC(i)/Q(i);
    AFC(i) = FC(i)/Q(i);
    MC(i) = 3*Q(i)^2-20*Q(i)+50;
end

createfigure(Q,[ATC AVC AFC MC]);

% Obliczenie optymalnej wielkoœci rocznej produkcji energii minimalizuj¹cej ATC (przeciêcie krzywej ATC i MC)
% ATC: Q^2-10*Q+50+(500/Q)
% MC: 3*Q^2-20*Q+50
% ATC = MC: 
% Q^2-10*Q+50+(500/Q) = 3*Q^2-20*Q+50
% 2*Q^2-10*Q-(500/Q) = 0 /*Q
% 2*Q^3-10*Q^2-500 = 0

C = [2 -10 0 -500]; % Wektor wspó³czynników równania 3 stopnia
roots0 = roots(C);
Q0 = real(roots0(1)); % Optymalna wielkoœæ rocznej produkcji energii (TWh)






