%% Matlab template for Scenario X, Dr Chin-Pang Liu, UCL
%
% This example shows how to acquire an audio signal using your microphone,
% perform basic signal processing, and play back your processed
% signal.

%% Create input and output objects
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);

%% Code for stream processing
% Place the following steps in a while loop for continuous stream
% processing:
%   1. Call your audio device reader with no arguments to
%   acquire one input frame. 
%   2. Perform your signal processing operation on the input frame.
%   3. Call your audio device writer with the processed
%   frame as an argument.

disp('Begin Signal Input...')
tic
while toc<10 %This loop runs for 10 seconds.
    
    % This line captures your input signal one frame at a time. Each frame 
    % has 1024 samples by default. Therefore it does not cature the entire 
    % 10-second audio clip in a go.
    InputSignal = deviceReader(); 
    
    % This increases the audio volumn by 50%. This is just an example and 
    % you can and should include your own signal processing steps in the loop. 
    % Remember you only have 1024 samples (a frame) to work with each time 
    % and some processes such as filtering will produce extra samples which 
    % need to be added to the following frame.
    OutputSignal = InputSignal * 1.5; 
    
    % This line sends the processed frame to the output audio device, i.e., 
    % your speakers.
    deviceWriter(OutputSignal);
    
end
disp('End Signal Input')

release(deviceReader)
release(deviceWriter)
