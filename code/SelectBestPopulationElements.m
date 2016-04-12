function [ population ] = SelectBestPopulationElements( population, maxAmount )
%SELECTNESTPOPULATIONELEMENTS Summary of this function goes here
% Select best k (maxAmount) models from population according to the model errors
%
% Inputs:
% population - cell array of models;
% maxAmount - number k of top-k models
%
% Outputs:
% population - cell array of top-k models

errors = cellfun(@(x){x.Handle}, population);
[~, ia, ic] = unique(errors,'rows');
population = population(ia);

errors = cellfun(@(x)x.Error, population);
[~, sortedIdcs] = sort(errors);
population = population(sortedIdcs(1 : min(maxAmount, length(population))));

end

