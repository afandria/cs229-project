clear all;
close all;
clc;

ROOT = 'G3_data';

tic
[trainX, trainY, testX, testY] = getTrainAndTestData({'acl8117', 'ubm'}, ROOT, @reductionOverTimeSteps, 'verification', 0.1, 1);

ITERATIONS = 100;
TRAIN_FUNCTION = 'trainlm'; %'trainbr';
[net, perf, fp,fn] = runFeedForwardNet(trainX, trainY, testX, testY, [10 12], ITERATIONS,'verification', TRAIN_FUNCTION);

perf %OOS error

inY = net(trainX');
perform(net, trainY', inY) %INsample error
toc