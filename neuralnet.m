     [x,t] = simplefit_dataset;
     net = feedforwardnet([10 4]);
     net = train(net,x,t);
     view(net)
     y = net(x);
     perf = perform(net,t,y);
     
     
     %%In case we want to use inputs that are vectors then we need to
     %%specify that in the creation of the neural net.
     %%eg
     
     [x,t] = simplefit_dataset;
     x =[x;x];
     t=[t;t];
     net = feedforwardnet([2 10 4]);
     net = train(net,x,t);
     view(net)
     y = net(x);
     perf = perform(net,t,y);
     