deviceReader = audioDeviceReader;

number_of_samples = 1024;
fs = 44100;
L = number_of_samples;
f = fs * (0:(L/2))/L;

%sine array for 1024 samples
t = 0:1/fs:10/7000;
array = sin(2*pi*7000*t);
for n =1:4
    array = [array array];
end

%10s input like in template
tic
while toc<10
%one frame input test
InputSignal = deviceReader();

%flipping the signal
OutputSignal = InputSignal.*array';
end

%input signal in frequency domain
inputfft = fft(InputSignal);
P2 = abs(inputfft/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%output signal in frequency domain
outputfft = fft(OutputSignal);
P4 = abs(outputfft/L);
P3 = P4(1:L/2+1);
P3(2:end-1) = 2*P3(2:end-1);

figure(1);
plot(f,P3);
hold on
plot(f,P1);
xlim([0 10000])
grid on
grid minor
legend('output signal','input signal')

