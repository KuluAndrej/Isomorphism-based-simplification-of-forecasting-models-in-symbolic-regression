function [population] = RandomModels(primitives, populationSize, RANDICONST)
    population = cell(1, populationSize);
    for mdlIdx = 1 : populationSize
        population{mdlIdx} = CreationModel(primitives, RANDICONST);
    end;
end

function [model] = CreationModel(primitives, RANDICONST)
    DEVIATION = 4;
    %handle            = Recfun(primitives,randi(RANDICONST,1,1));
    handle            = Recfun(primitives,abs(round(DEVIATION*randn(1)+RANDICONST))+1);
    [model, handle]   = GetModel(handle);
    [model.Handle, model.InitParams, model.ParamNums] = AdjParamsSelf(handle, model.Tokens);
    
    model.ParDom = arrayfun(@(x)primitives{1}{1}.ParDom, 1:length(model.Tokens), 'UniformOutput', false)';
    model.ArgDom = arrayfun(@(x)primitives{1}{1}.ArgDom, 1:length(model.Tokens), 'UniformOutput', false)';
    model.Tex    = arrayfun(@(x)primitives{1}{1}.Tex, 1:length(model.Tokens), 'UniformOutput', false)';
end

function [handle] = Recfun(primitives, param)
    if param==1
        if randi(2,1,1)==1
            handle = 'x(:,1)';
        else 
            handle = 'x(:,2)';
        end
        return
    end
      
    if param==2
        indRootTok = randi(length(primitives{1}),1,1); 
        if randi(2,1,1)==1
            if primitives{1}{indRootTok}.NumParams~=0
                handle = [primitives{1}{indRootTok}.Name,'(w_,x(:,1))']; 
            else
                handle = [primitives{1}{indRootTok}.Name,'([],x(:,1))']; 
            end
        else 
            if primitives{1}{indRootTok}.NumParams~=0
                handle = [primitives{1}{indRootTok}.Name,'(w_,x(:,2))']; 
            else
                handle = [primitives{1}{indRootTok}.Name,'([],x(:,2))']; 
            end
        end
        
        return
    end
    numofChildren = randi(2,1,1);
    if numofChildren==2
        try
            newParam = randi(param-2,1,1);
        catch
            param
        end
        indRootTok = randi(length(primitives{2}),1,1);
        if primitives{2}{indRootTok}.NumParams ==0
            handle = [primitives{2}{indRootTok}.Name,'([],',Recfun(primitives,newParam),',',Recfun(primitives,param-newParam-1),')'];
        else
            handle = [primitives{2}{indRootTok}.Name,'(w_,',Recfun(primitives,newParam),',',Recfun(primitives,param-newParam-1),')'];
        end
        return
    else
        indRootTok = randi(length(primitives{1}),1,1);
        if primitives{1}{indRootTok}.NumParams~=0
            handle = [primitives{1}{indRootTok}.Name,'(w_,',Recfun(primitives,param-1), ')'];
        else
            handle = [primitives{1}{indRootTok}.Name,'([],',Recfun(primitives,param-1), ')']; 
        end
    end
end

function [model, handle]  = GetModel(handle)
    %handle = regexprep(handle,'w\(\d*:\d*\),','');  
    
    handle = regexprep(handle,'@\(w,x\)','');
    handle = regexprep(handle,'w\(\d*:\d*\),','w_,');
    constHandle = handle;
    
    handle = regexprep(handle,'\[\],','');
    handle = regexprep(handle,'w_,','');
    handle = regexprep(handle,'w\(\d*:\d*\),',''); 
    handle = regexprep(handle,'x\(:,1\)','x1');
    handle = regexprep(handle,'x\(:,2\)','x2');
    [model.Mat, model.Tokens] = CreateMatByString(handle);
    model.FoundParams = [];
    handle = ['@(w,x)',constHandle];
end

function [handle, params, paramNum] = AdjParamsSelf(handle, Tokens)
    fileName  = 'numbParam.txt';
    inputfile = fopen(fileName);
    matValues = textscan(inputfile, '%s%f%f', 'delimiter', ' ');
    vecDates  = matValues{1};
    vecParams = matValues{2};
    fclose('all'); 
    vEncode = arrayfun(@(x) find(strcmp(Tokens{x},vecDates)),1:length(Tokens));
    vecPremParams = vecParams(vEncode);
    
    params = cell(length(Tokens), 1);
    for ii=1:length(vecPremParams)
        params{ii} = ones(1,vecPremParams(ii));
    end
    
    vecNonZPar = vecPremParams(find(vecPremParams~=0));
    paramNum = vecPremParams;
    start = 1;
    for ii = 1:length(vecNonZPar)
        handle = regexprep(handle,'w_,',['w(',sprintf('%.0f',start),':',sprintf('%.0f',start+vecNonZPar(ii)-1),'),'],'once');
        start = start + vecNonZPar(ii);
    end
end

function [] = modelInfo(model)
       fprintf('model.Handle = %s\n', model.Handle);
       model.Mat
       %celldisp(model.Tokens);
end

