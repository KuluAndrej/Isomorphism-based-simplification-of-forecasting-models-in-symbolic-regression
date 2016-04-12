function [newPrimitives] = AdjPrimitives(primitives,varNumb)
    numTokVarai = cellfun(@(x)x.Nargmax, primitives);
    newPrimitives = cell(varNumb,1);
    for ii = 1:varNumb
        indsArg = numTokVarai==ii;
        newPrimitives{ii} = primitives(indsArg);
    end
end