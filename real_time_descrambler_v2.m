clc
clear all 
close all

fileReader = dsp.AudioFileReader('Secret_message.wav');
deviceWriter = audioDeviceWriter('SampleRate',fileReader.SampleRate);

%%h = fdesign.bandstop('N,Fp1,Fp2,Ast', 5, 7950, 8050, 60,1024);
%%bandstop = design(h, 'cheby1');

%%h1  = fdesign.lowpass('N,Fp,Ast', 15, 8000, 50, 1024);
%%lowpass = design(h1, 'cheby1');

[b,a] = cheby2(5,60,[7950/22050 8050/22050],'stop');
[hn,t] = impz(b,a,1024,44100);
bandstop = hn;

[d,c] = cheby2(15,50,8000/22050,'low');
[hlp,t] = impz(c,d,1024,44100);
lowpass = hlp;

fs = fileReader.SampleRate;

t = 0:1/44100:10/7000;
array = sin(2*pi*7000*t);
buffer = zeros(1024,1); 

n = 0;

disp('Begin Signal Input...')

%while toc<8 %This loop runs for 8 seconds.

while ~isDone(fileReader) %This loop runs until file is read.
    
    InputSignal = fileReader(); 
    
    sf=conv(InputSignal,bandstop);
    if n < 9
        signal_1 =  sf.*array(n*1024+1:n*1024+length(sf));
        n = n + 1;
    elseif n == 9
        signal_1 =  sf.*[array(9*1024+1:end); array(1:length(sf)-1024)];
        n = 0;
    end
    signal_out=conv(signal_1,lowpass);
    
    OutputSignal = signal_out(1:1024)+buffer; 
    OutputSignal = OutputSignal*3; %%increase volume 
    buffer =[ signal_out(1024+1:end) ;  zeros(1024-200,1) ]; 
    
   
    deviceWriter(OutputSignal);
    
end
disp('End Signal Input')
release(fileReader)
release(deviceWriter)
