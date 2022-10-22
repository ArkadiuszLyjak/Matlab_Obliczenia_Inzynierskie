%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arkadiusz £yjak, 170330, Gr. 3 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clearvars;
clc; 

A1 = 2; % Amplituda
A2 = 2.5;
F1 = 10; % [Hz]
F2 = 50;
fi1 = 0;
fi2 = 1;
Fs = 512;
Ts = 1/Fs;
omega1 = 2*pi*F1;
omega2 = 2*pi*F2;
t = 0:Ts:(1-Ts);
y1 = A1*sin(omega1*t+fi1)+0;
y2 = A2*sin(omega2*t+fi2)+0;

figure;
plot(t, y1, '--gs', 'LineWidth',1, ...
                    'MarkerSize',2, ...
                    'MarkerEdgeColor','r', ...
                    'MarkerFaceColor',[0.5,0.5,0.5]); grid on 
axis([0,2/F1,-A2,A2]);
% l_okresow = num2str(2/F1,'%10.5e');
title('Sygnal y1', 'FontSize',12, 'FontWeight','bold','Color','b')
xlabel('t[s]', 'FontSize', 12, 'FontWeight','bold','Color','b'); 
ylabel('Amplituda', 'FontSize', 12, 'FontWeight','bold','Color','b'); 

hold

plot(t, y2), grid on
title('Sygnal y1+y2'); 
xlabel('t[s]', 'FontSize', 12, 'FontWeight','bold','Color','b'); 
ylabel('Amplituda', 'FontSize', 12, 'FontWeight','bold','Color','b'); 

figure;
subplot(2, 1, 1);
plot(t, y1), grid on
title('Sygnal y1')
xlabel('t[s]'); ylabel('Amplituda')
subplot(2, 1, 2); 
plot(t, y2, 'g'), grid on
title('Sygnal y2'); xlabel('t[s]'); ylabel('Amplituda')