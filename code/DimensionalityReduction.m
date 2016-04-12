function model = DimensionalityReduction( model )

[model.Handle, model.HandleWithoutParams, paramNums, numberOfParameters] = dimensionality_reduction([model.Encoding; model.Mat]);
initParams = cell(length(paramNums), 1);
for ii = 1 : length(paramNums)
   initParams{ii} = zeros(1, paramNums(ii));
end
model.InitParams = initParams;
model.ParamNums = paramNums';
model.NumberOfParameters = numberOfParameters;
end

