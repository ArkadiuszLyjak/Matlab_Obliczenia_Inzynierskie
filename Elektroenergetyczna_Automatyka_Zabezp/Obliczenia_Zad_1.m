clc;
clearvars;
close all;

I = 9;
N = 5;
nr = 14;

%Parametry transformatorow dwuuzwojeniowych
SnT1 = 50; %[MVA] moc znam. trafa T1
SnT2 = 25; %[MVA] moc znam. trafa T2
SnT3 = SnT2; %[MVA] moc znam. trafa T3
thetaT1 = 10.5/115.5; %przekladnia trafa T1
thetaT2 = 6.3/115.5; %przekladnia trafa T2
thetaT3 = thetaT2; %przekladnia trafa T3
UzT1 = 11; %napiecie zwarcia trafa T1 [%]
UzT2 = UzT1; %napiecie zwarcia trafa T2 [%]
UzT3 = UzT1; %napiecie zwarcia trafa T3[ %]

%Parametry transformatora trojuzwojeniowego
SnT4 = 25; %[MVA] moc znam. trafa T4
thetaT4 = 115.5/15.75/6.3; %przekladnia trafa T4
Uz110_15T4 = 11; %napiecie zwarcia (110-15) trafa T4[%]
Uz15_6T4 = 6; %napiecie zwarcia (15-6) trafa T4[%]
Uz110_6T4 = 18; %napiecie zwarcia (110-6) trafa T4[%]

%Parametry generatorów i silnika synchronicznego
SnG1 = 55; %[MVA] moc znam. generatora G1
SnG2 = 25; %[MVA] moc znam. generatora G2
SnG3 = SnG2; %[MVA] moc znam. generatora G3
SnG4 = SnG2; %[MVA] moc znam. generatora G4
SnM = 15; %[MVA] moc znam. silnika synchronicznego
UnG1 = 10.5; %napiecie znam. [kV] generatora G1
UnG2 = 6.3; %napiecie znam. [kV] generatora G2
UnG3 = UnG2; %napiecie znam. [kV] generatora G3
UnG4 = UnG2; %napiecie znam. [kV] generatora G4
UnM = 15.75; %napiecie znam. [kV] silnika synch.
XdG1_II = 14.6; %reaktancja podprzejsciowa [%] gen. G1
XdG2_II = 12.8; %reaktancja podprzejsciowa [%] gen. G2
XdG3_II = XdG2_II; %reaktancja podprzejsciowa [%] gen. G3
XdG4_II = XdG2_II; %reaktancja podprzejsciowa [%] gen. G4
XdM_II = 18; %reaktancja podprzejsciowa [%] silnika synch

%Parametry linii elektroenergetycznych
UnL = 110; %napiecie znam. linii [kV]
w1 = (80+5*nr)*(I/(I+N)); %dlugosc [km] linii L1
XLw1 = 0.4; %reaktancja jednostkowa [ohm/km] linii L1
w2 = (80+5*nr)*(N/(I+N)); %dlugosc [km] linii L2
XLw2 = XLw1; %reaktancja jednostkowa [ohm/km] linii L2
%Obliczenia reaktancji w jednostkach mianowanych
X1L1 = w1*XLw1; %reaktancja linii L1 [ohm]
X1L2 = w2*XLw2; %reaktancja linii L2 [ohm]

%Jednostki bazowe
S_b = 100; %[MVA]
U_bL = 1.05*UnL;
U_bG1 = 1.05*UnG1; %[kV]
U_bG2 = 1.05*UnG2; %[kV]
U_bG3 = 1.05*UnG3; %[kV]
U_bG4 = 1.05*UnG4; %[kV]
I_bG1 = (S_b/(sqrt(3)*U_bG1)); %[kA]
I_bG2 = (S_b/(sqrt(3)*U_bG2)); %[kA]
I_bG3 = (S_b/(sqrt(3)*U_bG3)); %[kA]
I_bG4 = (S_b/(sqrt(3)*U_bG4)); %[kA]
X_bG1 = U_bG1^2/S_b; %[ohm]
X_bG2 = U_bG2^2/S_b; %[ohm]
X_bG3 = U_bG3^2/S_b; %[ohm]
X_bG4 = U_bG4^2/S_b; %[ohm]

%1. Schemat zastepczy sieci dla skladowej zgodnej

%2.  Reaktacje zastepcze silnika M, trafa T4
X1Mpu = (XdM_II/100)*(S_b/SnM); %????????????????????????????????????
X1T4_110pu = (1/2)*((Uz110_15T4+Uz110_6T4-Uz15_6T4)/100)*(S_b/SnT4);
X1T4_15pu = (1/2)*((Uz110_15T4+Uz15_6T4-Uz110_6T4)/100)*(S_b/SnT4);
X1T4_6pu = (1/2)*((Uz110_6T4+Uz15_6T4-Uz110_15T4)/100)*(S_b/SnT4);

%3. Reaktancja zastêpcza widziana z miejsca zwarcia
%Obliczanie reaktancji w pu potrzebnych w dalszych krokach
X1T1pu = (UzT1/100)*(S_b/SnT1);
X1T2pu = (UzT2/100)*(S_b/SnT2);
X1T3pu = (UzT3/100)*(S_b/SnT3);

X1G1pu = (XdG1_II/100)*(S_b/SnG1);
X1G2pu = (XdG2_II/100)*(S_b/SnG2);
X1G3pu = (XdG3_II/100)*(S_b/SnG3);
X1G4pu = (XdG4_II/100)*(S_b/SnG4);

X1L1pu = (S_b*w1*XLw1)/(U_bL^2);
X1L2pu = (S_b*w2*XLw2)/(U_bL^2);

X1Zas1 = X1L1pu+X1T1pu+X1G1pu;
X1Zas2 = X1T2pu+X1G2pu;
X1Zas3 = X1T3pu+X1G3pu; 
X1ZasM = X1Mpu+X1T4_15pu;
X1Zas4 = X1T4_6pu+X1G4pu;


X1Lewa = X1L2pu + (((X1Zas3)*(X1Zas2)*(X1Zas1))/(X1Zas1*X1Zas2+X1Zas1*X1Zas3+X1Zas2*X1Zas3));
X1Prawa = X1T4_110pu + (X1ZasM*X1Zas4)/(X1ZasM+X1Zas4);
X1th = (X1Lewa*X1Prawa)/(X1Lewa+X1Prawa);

%4. Skladowa zgodna pradu zwarcia
















