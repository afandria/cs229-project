clear all;
close all;
clc;

%fileName = 'sa1.wav';

%[x,phoneme,endpoints] = wavReadTimit(fileName);
%spectrogram(x')

T = 0:0.001:2;
X = chirp(T,100,1,200,'q');
spectrogram(X,128,120,128,1E3); 
title('Quadratic Chirp')
