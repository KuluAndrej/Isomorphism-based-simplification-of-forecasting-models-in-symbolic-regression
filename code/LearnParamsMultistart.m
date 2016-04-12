function model = LearnParamsMultistart(model, data, nlinopt, issimpl, prevHandle, numberOfParameters)

xcontrol  = data.Xtest;
x         = data.X;
ycontrol  = data.Ytest;
y         = data.Y;

model.FoundParams = [];
handle = str2func(model.Handle);
initParams  = 0.01*ones(1,numberOfParameters);
%initParams  = zeros(1,numberOfParameters);
isfailed = 0;
model.MSE = Inf;
model.Control = Inf;
model.Error = Inf;   
% 10 times generate random initial parameters
for jj = 1:10
    initParams = unifrnd(0,1,size(initParams));
   
    if ~isempty(model.InitParams)
        try
            [model.FoundParams, ~, ~, ~, model.MSE] =...
                nlinfit(x, y, handle, initParams, nlinopt); % find parameters    
        catch
            %disp('nlinfit failed, Found Params = Init Params')
            %model.Handle
            model.FoundParams = initParams;
            isfailed = 1;
        end
        if (isreal(model.FoundParams) == 0)
            model.MSE = min(model.MSE, Inf);
            model.Control = min(model.Control, Inf);
            model.Error = min(model.Error, Inf);   
        else
            model.MSE = min(model.MSE, mean( (handle(model.FoundParams, x) - y) .^ 2));
            model.Control = min(model.Control, mean( (handle(model.FoundParams, xcontrol) - ycontrol) .^ 2));
            model.Error = min(model.Error, errorFun(model.MSE, model.FoundParams, length(model.Tokens), size(x,1)));     
            
        end    
    end    
end
%[model.MSE, model.Error, model.Control]        

end

function [aic] = errorFun (MSE, parameters, modelComplexity, ~)
    constInterpr = 20;
    penaltyForSimpleFun = 0.1;
    penaltyForCompliFun = 1;
    
    aic = 0.000035*norm(parameters) + MSE;
    
    if modelComplexity < constInterpr
        aic = aic + penaltyForSimpleFun*MSE*modelComplexity;
    else
        aic = aic + penaltyForCompliFun*MSE*(modelComplexity-constInterpr)+penaltyForSimpleFun*MSE*constInterpr;
    end    
end
