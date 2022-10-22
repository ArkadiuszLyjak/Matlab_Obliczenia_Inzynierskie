clc;
clearvars;
close all;

[y, fs] = audioread('LAB_sampl1.wav');
t = 0 : 1/fs : length(y)/fs-1/fs;
y_out = zeros(length(y),1);

% maxdelay = 1/fs;
maxdelay1 = 5000;
maxdelay2 = 8000;
maxdelay3 = 10000;

delay1 = round((sawtooth(2*pi*t*0.5,0.5)+1)*maxdelay1);
delay2 = round((sawtooth(2*pi*t*0.5,0.5)+1)*maxdelay2);
delay3 = round((sawtooth(2*pi*t*0.5,0.5)+1)*maxdelay3);


% delay = round((sawtooth(2*pi*t*0.5,0.5)+1)*maxdelay);
% t = 1:1:length(y);
f = 50;

for i = 1:length(y)
    
%     n = i - fs/2;
%     n1 = delay1(i);
%     n2 = delay2(i);
%     n3 = delay3(i);

    n1 = i - delay1(i);
    n2 = i - delay2(i);
    n3 = i - delay3(i);
    
    if(n3>0)
        % Echo pojedyncze.
%         y_out(i) = y(i)+0.8*y(n);
        % Echo wielokrotne.
%         y_out(i) =  0.1*y(i-100)+0.5*y(i-200)+0.9*y(i-300)+ ...
%                     y(i)+0.8*y(n);
        % Flanger/Chorus effect.
%         y_out(i) = y1(i)*y_out(i);
        y_out(i) = y(i)+y(n1)+y(n2)+y(n3);
        
    else
        y_out(i)  = y(i);
    end
end

% Teraz taki manewer, ze w obu uchach slyszymy co innego.
y2 = [y';y_out'];
y1 = 1 * sawtooth(2 * pi / 2 * t * f,0.5) + 0;

% plot(t(1:100),y1(1:100));
soundsc(y2,fs); % Odegranie pliku.
