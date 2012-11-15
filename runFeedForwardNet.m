
function [perf,err] =runFeedForwardNet(trainX,trainY,testX,testY,hidden)
inputsize = size(trainX',1);
%inputsize
%hidden
net = patternnet([hidden]);
net.trainParam.epochs = 50;
net.trainParam.showWindow = 0;
net = train(net,trainX',trainY');
y = net(testX');
err =0;
for i = 1:size(y,2)
   y(:, i)
   testY(i, :)'
    err = err + norm(y(:, i)-testY(i, :)') ;
end
%err 
%size(y,2)
err = err/size(y,2)
perf = perform(net,testY',y)
     