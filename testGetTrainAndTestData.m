clear all;
close all;
clc;

[trainX, trainY, testX, testY] = getTrainAndTestData({'madd0', 'fblv0', 'maeo0'}, 'dr7', @reductionOverFrequency, 'verification', 0.20);