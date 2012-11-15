clear all;
close all;
clc;

[trainX, trainY, testX, testY] = getTrainAndTestData({'madd0', 'fblv0', 'maeo0'}, 'dr7', @reductionOverTimeSteps, 'verification', 0.20);

ITERATIONS = 30;
[net, perf, err] = runFeedForwardNet(trainX, trainY, testX, testY, [10 4], ITERATIONS);

perf %OOS error

inY = net(trainX');
perform(net, trainY', inY) %INsample error