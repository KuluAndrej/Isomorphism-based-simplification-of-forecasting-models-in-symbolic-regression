function [ population ] = LearnPopulation( population, data, nlinopt )
%LEARNPOPULATION
% Adjust parameters for each model in a population
%
% Inputs:
% population - cell array of models;
% y - m-by-1 target variable;
% X - m-by-n independent variable
% nlinopt - options for nlinfit (nonlinear regression adjustment) method
% pltopt - plotting options
%
% Outputs:
% population - cell array of model with adjusted parameters

for modelIdx = 1 : length(population)
    % Adjust parameters
    numberOfParameters = size(cell2mat(population{modelIdx}.InitParams'),2);
    
    %model = LearnParamsMultistart(population{modelIdx}, data, nlinopt, 0, population{modelIdx}.Handle, numberOfParameters);
    model = LearnModelParams(population{modelIdx}, data, nlinopt, 0, population{modelIdx}.Handle, numberOfParameters);
    population{modelIdx} = model;
    
    % Plot result
    %PlotStruct(str2func(population{modelIdx}.Handle), population{modelIdx}.FoundParams, X, y, pltopt);
end

end

