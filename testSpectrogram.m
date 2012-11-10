clear all;
close all;
clc;

fileName = 'sa1.wav';

[x,phoneme,endpoints] = wavReadTimit(fileName);
x = x(1:32768);
S = spectrogram(x', 320, 160, 512, 16000);
spectrogram(x', 320, 160, 512, 16000);
% 
figure
fileName = 'dr7/madd0/sa1.wav';
% [file, path] =  uigetfile('*', 'Select data file', '.');
% fileName =fullfile(path, file);

[x,phoneme,endpoints] = wavReadTimit(fileName);
x = x(1:32768);
S2 = spectrogram(x', 320, 160, 512, 16000);
spectrogram(x', 320, 160, 512, 16000);

% T = 0:0.001:2;
% X = chirp(T,100,1,200,'q');
% spectrogram(X,128,120,128,1E3); 
% title('Quadratic Chirp')

% Go with mean, and standard deviation, (and maybe max)
% So we need a function called reduce(matrix) -> reducedMatrix
% We can reduce frequency-wise or time-wise.