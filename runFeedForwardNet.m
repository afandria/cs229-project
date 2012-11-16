
function [net,perf,fp,fn] =runFeedForwardNet(trainX,trainY,testX,testY,hidden, iterations,task)
inputsize = size(trainX',1);
%inputsize
%hidden
net = patternnet([hidden],'trainbr');
net.trainParam.epochs = iterations;
net.trainParam.showWindow = 0;
[net,tr] = train(net,trainX',trainY');
y = net(testX');
err =0;
fp = 0;
fn = 0;

if(strcmp(task,'verification'))%find some other interesting errors in the case of identification task
    for i = 1:size(y,2)
        y(:, i);
        testY(i, :)';
        if(y(1,i) > y(2,i))
            y(1,i) = 1;
            y(2,i) =0;
        else
            y(1,i)=0;
            y(2,i) = 1;
        end
        err = norm(y(:, i)-testY(i, :)');            
       if(err > 0)%not exact match 
        if(y(1,i) ==1) % this is a false positive
            fp = fp +1;
        else 
           fn = fn + 1;
        end
        
       end
    end
end
%err 
%size(y,2)
%err = err/size(y,2);
fp = fp;
fn = fn;
plotperform(tr);

perf = perform(net,testY',net(testX'));

     