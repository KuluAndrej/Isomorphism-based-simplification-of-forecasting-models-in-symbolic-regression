function [] = generator()
    
    %handle = '@(x,y)sin(0.3*x)*exp(0.09*y) + 0.00001*x.*x - 50 + x + exp(0.1*sin(0.05*x))';
    handle = '@(x,y)(2*sin(x*0.3 - 5)*exp(0.02*x) + exp(-0.02*x) + 500*exp(-0.001*(x + 200).^2) + 1000*exp(-0.001*(x + 100).^2) + 0.01*x.*x + x)/1000';
    %handle = '@(x,y)sin(x*0.25 + 5)*exp(0.02*x)';

    %handle = '@(x,y)sin(x*25 + 5)*exp(5*y)';
    % numb of tokens = 7
    
    funct = str2func(handle);
    x = [-300:1:300]';
    data = arrayfun(funct, x);
    data = awgn(data,23,'measured');
    dlmwrite('demo.dat.txt', [data, x]);
    mean(data)
    plot(x, data)
    
    
    %surf(X,Y,data)
    %{
    handle1 = '@(x,y)sin(x*25 + 5)*exp(5*y)';
    handle2 = '@(x,y)2*x*x - x + 1';
    funct1 = str2func(handle1);
    funct2 = str2func(handle2);
    valuesX = [0:0.003:3]';
    valuesY = [-2:0.003:1]';
    data1 = arrayfun(funct1, valuesX, valuesY);
    data2 = arrayfun(funct2, valuesX, valuesY);
    [data1, data2]
    %}
end