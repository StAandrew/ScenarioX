% [b,a] = cheby2(5,80,[7950/22050 8050/22050],'stop');

[h,t] = impz(notch,1024,44100);
figure;
plot(t,h,'k-')

y = sin(2.*pi.*5000.*t);
yfft = fft(y)
Py = abs(yfft)
f = [1:11000/1024:11000];
figure(2);
plot(t,y,'k-');
xlim([0 0.001]);

figure(3);
plot(f,Py,'k-');