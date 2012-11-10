     [x,t] = simplefit_dataset;
     net = feedforwardnet(10);
     net = train(net,x,t);
     view(net)
     y = net(x);
     perf = perform(net,t,y);