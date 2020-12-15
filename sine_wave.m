number_of_periods = 10

%actual code to use in final to make array of 7 kHz sine values
t = 0:1/44100:number_of_periods/7000;
y = sin(2*pi*7000*t);
% yes it's just 2 lines

%adding 2 arrays 1 after each other to test if it matches actual sine
samples = [y y]
time = [t (10/7000)+t]
plot(time,samples,'-o')
hold on

%actual sine
syms t
y = sin(2*pi*7000*t)
fplot(y)
xlim([0 2*number_of_periods/7000])
