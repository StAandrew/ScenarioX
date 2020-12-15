[b,a] = cheby2(15,50,8000/22050,'low');
L = 1024;
L2 = 2047;
fs = 44100;
f = fs * (0:(L/2))/L;
f2 = fs * (0:(L2/2))/L2;

[h,t] = impz(b,a,1024,44100);
figure(1)
plot(t,h,'k-')

yfilter = conv(h,y);
filteredFft = fft(yfilter);
P4 = abs(filteredFft/L2);
P3 = P4(1:L2/2+1);
P3(2:end-1) = 2*P3(2:end-1);

figure(4);
plot(f2,P3,'k-');

%%[k,f] = freqz(b,a,256,44100);
%%dB = mag2db(abs(h));


y = sin(2*pi*2000*t) + sin(2*pi*3000*t) + sin(2*pi*4000*t)+ sin(2*pi*5000*t) + sin(2*pi*6000*t) + sin(2*pi*7000*t) + sin(2*pi*8000*t)+ sin(2*pi*9000*t) + sin(2*pi*10000*t) + sin(2*pi*11000*t) + sin(2*pi*12000*t)+ sin(2*pi*13000*t);
yfft = fft(y);
P2 = abs(yfft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure(2);
plot(t,y,'k-');
xlim([0 0.001]);

figure(3);
plot(f,P1,'k-'); 

