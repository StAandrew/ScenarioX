clc;
clear all;

[b,a] = cheby2(5,60,[7950/22050 8050/22050],'stop');

L = 1024;
L2 = 2047;
fs = 44100;
f = fs * (0:(L/2))/L;
f2 = fs * (0:(L2/2))/L2;

[h,t] = impz(b,a,1024,44100);
% figure;
% plot(t,h,'k-')

y = sin(2*pi*5500*t)+sin(2*pi*6000*t)+sin(2*pi*6500*t)+sin(2*pi*7000*t)+sin(2*pi*7500*t)+sin(2*pi*8000*t)+sin(2*pi*8500*t)+sin(2*pi*9000*t)+sin(2*pi*9500*t)+sin(2*pi*10000*t)+sin(2*pi*10500*t)+sin(2*pi*11000*t);
yfft = fft(y);
P2 = abs(yfft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

% figure(2);
% plot(t,y,'k-');
% xlim([0 0.001]);
% 
% figure(3);
% plot(f,P1,'k-');

yfilter = conv(h,y);
filteredFft = fft(yfilter);
P4 = abs(filteredFft/L2);
P3 = P4(1:L2/2+1);
P3(2:end-1) = 2*P3(2:end-1);

figure(4);
plot(f2,P3,'k-');