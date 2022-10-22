clc;
clearvars;
close all;

%%PARAMETRY ELEMENTÓW

%% Parametry transformatorów dwuuzwojeniowych
% Moce znamioniowe
Sn_T1 = 50;     %MVa
Sn_T2 = 25;     %MVa
Sn_T3 = Sn_T2;  %MVa

%Przek³adnia
Tau_T1 = 10.5/115.5 ;   %kV/kV
Tau_T2 = 6.3/115.5;     %kV/kV
Tau_T3 = Tau_T2;

%Napiêcie zwarcia
Uz_T1 = 11;     % w procentach
Uz_T2 = 11;     % w procentach
Uz_T3 = Uz_T2;  % w procentach

%% %% Parametry transformatora trójuzwojeniowego
% Moce znamioniowe
Sn_T4 = 25; % MVa

%Przek³adnia
Tau_T4_110_15 = 115.5/15.75;    %kV/kV
Tau_T4_15_6 = 15.75/6.3;        %kV/kV
Tau_T4_110_6 = 115.5/6.3;

%Napiêcie zwarcia
Uz_T4_110_15 = 11;  % w procentach
Uz_T4_15_6 = 6;     % w procentach
Uz_T4_110_6 = 18;   % w procentach

%% Parametry generatorów i silnika synchronicznego
% Moce znamionowe
Sn_G1 = 55;     %MVa
Sn_G2 = 25;     %MVa
Sn_G3 = Sn_G2;  %MVa
Sn_G4 = Sn_G2;  %MVa
Sn_M = 15;      %MVa

%Napiêcia znamionowe
Un_G1 = 10.5;   %kV
Un_G2 = 6.3;    %kV
Un_G3 = Un_G2;  %kV
Un_G4 = Un_G2;  %kV
Un_M = 15.75;   %kV

%Reakctacja podprzejsciowa
Xd_bis_G1 = 14.6;
Xd_bis_G2 = 12.8;
Xd_bis_G3 = Xd_bis_G2;
Xd_bis_G4 = Xd_bis_G2;
Xd_bis_M = 18;

%%Parametry linii
Imie = 'Arkadiusz';
nazwisko = 'Lyjak';
I = length(Imie);
N = length (nazwisko);
nr = 14;

w1_dlug_linii_1 = (80+5*nr)*I/(I+N);
w2_dlug_linii_2 = (80+5*nr)*N/(I+N);

L_L1 = w1_dlug_linii_1;
L_L2 = w2_dlug_linii_2;

Reakt_Jedn = 0.4;
X_0_do_X_1 = 2.8;

%Jednostki bazowe
Sb = 100 ; %MVA
Un = 110; %kV
Ub = 1.05*Un;
Ub_G1 = 1.05*Un_G1; %[kV]
Ub_G2 = 1.05*Un_G2; %[kV]
Ub_G3 = 1.05*Un_G3; %[kV]
Ub_G4 = 1.05*Un_G4; %[kV]
Ib_G1 = (Sb/(sqrt(3)*Ub_G1)); %[kA]
Ib_G2 = (Sb/(sqrt(3)*Ub_G2)); %[kA]
Ib_G3 = (Sb/(sqrt(3)*Ub_G3)); %[kA]
Ib_G4 = (Sb/(sqrt(3)*Ub_G4)); %[kA]
Xb_G1 = Ub_G1^2/Sb; %[ohm]
Xb_G2 = Ub_G2^2/Sb; %[ohm]
Xb_G3 = Ub_G3^2/Sb; %[ohm]
Xb_G4 = Ub_G4^2/Sb; %[ohm]

%%Zastêpujemy generatory reaktancjami

%Obliczenie poszczególnych reaktancji dla sk³adowej zgodnej
% w jednostkach wzglednych

X1_L1_pu = w1_dlug_linii_1*Reakt_Jedn*Sb/Ub^2;
X1_L2_pu = w2_dlug_linii_2*Reakt_Jedn*Sb/Ub^2;

% Jednostki mianowane
X1_L1 = w1_dlug_linii_1*Reakt_Jedn;
X0_L1 = X1_L1*X_0_do_X_1;
X1_L2 = w2_dlug_linii_2*Reakt_Jedn;
X0_L2 = X1_L2*X_0_do_X_1;

X1_G1_pu = Xd_bis_G1*Sb/(100*Sn_G1);
X1_G2_pu = Xd_bis_G2*Sb/(100*Sn_G2);
X1_G3_pu = Xd_bis_G3*Sb/(100*Sn_G3);
X1_G4_pu = Xd_bis_G4*Sb/(100*Sn_G4);

X1_M_pu = Xd_bis_M*Sb/(100*Sn_M)

X1_T1_pu = Uz_T1*Sb/(100*Sn_T1);
X1_T2_pu = Uz_T2*Sb/(100*Sn_T2);
X1_T3_pu = Uz_T3*Sb/(100*Sn_T3);

% Obliczenie tranformatora T4
X1_T4_110_15 = Uz_T4_110_15*Sb/(100*Sn_T4);
X1_T4_15_6 = Uz_T4_15_6*Sb/(100*Sn_T4);
X1_T4_110_6 = Uz_T4_110_6*Sb/(100*Sn_T4);

% Zamieniamy polaczenie 'trojkat' w 'gwiazde'
X1_T4_110 = 0.5*(X1_T4_110_15+X1_T4_110_6-X1_T4_15_6)
X1_T4_15 = 0.5*(X1_T4_110_15+X1_T4_15_6-X1_T4_110_6)
X1_T4_6 = 0.5*(X1_T4_110_6+X1_T4_15_6-X1_T4_110_15)

%Uproszczenie sieci. Dodawanie szeregowych polaczen

X1_G1_T1_pu = X1_T1_pu+X1_G1_pu; 
X1_G2_T2_pu = X1_T2_pu+X1_G2_pu;
X1_G3_T3_pu = X1_T3_pu+X1_G3_pu;
X1_T4_15_M_pu = X1_T4_15+X1_M_pu;
X1_T4_6_G4_pu = X1_T4_6+X1_G4_pu;

%Uproszczenie cd. Obliczenie polaczen rownoleglych
X1_BN_P = X1_T4_110+X1_T4_15_M_pu*X1_T4_6_G4_pu/(X1_T4_15_M_pu+X1_T4_6_G4_pu);
X1_CNd = X1_G2_T2_pu*X1_G3_T3_pu/(X1_G2_T2_pu+X1_G3_T3_pu);

%%Podpunkt A. Obliczenie pradu w miejscu zwarcia
% Wyznaczenie reaktancji w miejscu zwarcia
% wyznaczenie reaktancji z lewej strony od zwarcia
% Mamy reaktancje X1_L2, X1_C, X1_G1_T1, X1_L1
X1_BN_L = (X1_G1_T1_pu+X1_L1_pu)*X1_CNd/(X1_G1_T1_pu+X1_L1_pu+X1_CNd)+X1_L2_pu;
X1Th_pu = X1_BN_P*X1_BN_L/(X1_BN_P+X1_BN_L) %w jednostkach wzglednych

U_zero_1_pu = 1.05;

%Skladowa zgodna pradu w miejscu zwarcia w jednostkach wzglednych
I1k_pu = U_zero_1_pu/X1Th_pu

a = exp(1i*rad2deg(120));
a_2 = exp(-1i*rad2deg(120));

S = [ 1 1 1
    1 a_2 a
    1 a a_2];

I_012_pu = [0; I1k_pu; 0];
IL_1_2_3_pu = [I1k_pu I1k_pu I1k_pu];

IL_1_2_3_jm = IL_1_2_3_pu*Sb/(sqrt(3)*Ub) %kA

%%Podpunkt B. Prad i napiecie w punkcie przekaznikowym P

I1_BNl = I1k_pu*X1_BN_P/(X1_BN_L+X1_BN_P); %prad doplywajacy do szyny B
I1P_pu = I1_BNl*X1_CNd/(X1_L1_pu+X1_G1_T1_pu+X1_CNd) % Skladowa zgodna pradu w punkcie przekaznikowym

% Wartosci fazowe pradu w punkcie P
I_L123_P_pu = [I1P_pu; I1P_pu; I1P_pu]; %wartosci fazowe pradu w punkcie P w jw
I_L123_P = I_L123_P_pu*Sb/(sqrt(3)*Ub) %wartosci fazowe pradu w punkcie P w jm 

% Wyznaczanie wartosci napiecia w punkcie P

U1P_pu = U_zero_1_pu-X1_G1_T1_pu*I1P_pu; %skladowa zgodna napiecia w punkcie P

UL_123_P_pu = [U1P_pu;U1P_pu;U1P_pu];
UL_123_P = UL_123_P_pu*Ub/sqrt(3) %kV

%% Podpunkt C. Prad i napicie zwarcia w przypadku zwarcia przez 
% rezystancje przejscia 2 om
R_p = 2; %Om
R_p_pu = R_p*Sb/Ub^2;

% skladowa zgodna pradu w jednostach wzglednych
I1_pu = U_zero_1_pu/(X1Th_pu+R_p_pu);
IL_123_pu = [I1_pu;I1_pu;I1_pu];
IL_123_2_om = IL_123_pu*Sb/(sqrt(3)*Ub) %kA

% skladowa zgodna napiecia
U1_pu = I1_pu*R_p_pu
UL_123_pu = [U1_pu;U1_pu;U1_pu];
UL_123 = UL_123_pu*Ub/sqrt(3);

%% Jednostki mianowane
%reaktancje generatorow i silnika
X1_prim_G1 = (Xd_bis_G1*Un_G1^2)/(100*Sn_G1);
X1_prim_G2 = (Xd_bis_G2*Un_G2^2)/(100*Sn_G2);
X1_prim_G3 = (Xd_bis_G3*Un_G3^2)/(100*Sn_G3);
X1_prim_G4 = (Xd_bis_G4*Un_G4^2)/(100*Sn_G4);
X1_prim_M = (Xd_bis_M*Un_M^2)/(100*Sn_M);

%reaktancje transformatorow
X1_T1 = (Uz_T1*110^2)/(100*Sn_T1);
X1_T2 = (Uz_T2*110^2)/(100*Sn_T2);
X1_T3 = (Uz_T3*110^2)/(100*Sn_T3);

%reaktancje generatorow i silnika preliczone na strone 110 kV

X1_G1 = X1_prim_G1*Tau_T1^2;
X1_G2 = X1_prim_G2*Tau_T2^2;
X1_G3 = X1_prim_G3*Tau_T3^2;
X1_G4 = X1_prim_G4*Tau_T4_110_6^2;
X1_M = X1_prim_M*Tau_T4_110_15^2;

%Reaktancje linii energetycznych
X1_L1 = w1_dlug_linii_1*Reakt_Jedn;
X1_L2 = w2_dlug_linii_2*Reakt_Jedn;

%Napiecia zwarcia poszczegolnych uzwojen T4
Uz_T4_110 = (Uz_T4_110_15+Uz_T4_110_6-Uz_T4_15_6)/2;
Uz_T4_15 = (Uz_T4_110_15-Uz_T4_110_6+Uz_T4_15_6)/2;
Uz_T4_6 = (-Uz_T4_110_15+Uz_T4_110_6+Uz_T4_15_6)/2;

%Reaktancje poszczegolnych uzwojen T4 na poziomie 110 kV
X1_T4_110 = Uz_T4_110*Un^2/(100*Sn_T4);
X1_T4_15 = Uz_T4_15*Un^2/(100*Sn_T4);
X1_T4_6 = Uz_T4_6*Un^2/(100*Sn_T4);

%Obliczenia w jednostkach mianowanych
%reaktancja zastepcza "na prawo" od zwarcia

X1BN_P = X1_T4_110+((X1_T4_15+X1_M)*(X1_T4_6+X1_G4))/((X1_T4_15+X1_M)+(X1_T4_6+X1_G4));
X1BN_L_1 = X1_G1+X1_T1+X1_L1;
X1BN_L_2 = X1_T2+X1_G2;
X1BN_L_3 = X1_T3+X1_G3;

X1BN_L = X1BN_L_1*X1BN_L_2*X1BN_L_3/(X1BN_L_1*X1BN_L_2+X1BN_L_1*X1BN_L_3+X1BN_L_2*X1BN_L_3);
X1_Th = X1BN_P*X1BN_L/(X1BN_P+X1BN_L)

%Skladowa zgodna pradu zwarcia w jedn mianowanych
I1 = 1.1*110/(sqrt(3)*X1_Th);
IL_123 = [I1;I1;I1]