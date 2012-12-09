clear all;
close all;
clc;

ROOT = 'dr7';
interestingPerson = 'madd0';

% get all the speakers inside the root directory
d = dir(ROOT);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

% remove the interesting speaker and prepend it to the front
nameFolds(ismember(nameFolds,{interestingPerson})) = [];
nameFolds = [{interestingPerson}; nameFolds];
nameFolds = nameFolds';

%[trainX, trainY, testX, testY] = getTrainAndTestData(nameFolds, ROOT, @reductionOverTimeSteps, 'recognition', 0.30,1.0);
tic
[trainX, trainY, testX, testY] = getTrainAndTestData({'madd0', 'fblv0', 'maeo0', 'mwrp0', 'mwre0'}, ROOT, @reductionOverTimeSteps, 'recognition', 0.30);
%[trainX, trainY, testX, testY] = getTrainAndTestData({'madd0', 'mwre0'}, ROOT, @reductionOverTimeSteps, 'recognition', 0.30);


ITERATIONS = 30;
[net, perf, fp,fn] = runFeedForwardNet(trainX, trainY, testX, testY, [10 4], ITERATIONS,'recognition');

perf %OOS error

inY = net(trainX');
perform(net, trainY', inY) %INsample error
toc