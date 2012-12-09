clear all;
close all;
clc;

%[trainX, trainY, testX, testY, S] = getTrainAndTestData({'madd0', 'fblv0', 'maeo0'}, 'dr7', @reductionOverTimeSteps, 's', 0.20);
[trainX, trainY, testX, testY, S] = getTrainAndTestData({'acl8117', 'avs2116'}, 'data', @reductionOverTimeSteps, 's', 0.20);