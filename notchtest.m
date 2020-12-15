[b,a] = cheby2(5,80,[7950/22050 8050/22050],'stop');

L = 1024;
fs = 44100;
f = fs * (0:(L/2))/L;

[h,t] = impz(b,a,1024,44100);
figure;
plot(t,h,'k-')

y = sin(2*pi*5500*t)+sin(2*pi*6000*t)+sin(2*pi*6500*t)+sin(2*pi*7000*t)+sin(2*pi*7500*t)+sin(2*pi*8000*t)+sin(2*pi*8500*t)+sin(2*pi*9000*t)+sin(2*pi*9500*t)+sin(2*pi*10000*t)+sin(2*pi*10500*t)+sin(2*pi*11000*t);
yfft = fft(y);
P2 = abs(yfft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(2);
plot(t,y,'k-');
xlim([0 0.001]);

figure(3);
plot(f,P1,'k-');