function [ firstCoModel, secondCoModel ] = CrossoverModels( firstModel, firstModelIdx, secondModel, secondModelIdx )
%CROSSOVERMODELS
% Makes models crossover; can be used in an evolutionary optimum search
%
% Inputs:
% firstModel - first model struct;
% firstModelIdx - index of a subtree (submodel) root which should be
%  replaced by a subtree of the second model
% secondModel - second model struct;
% secondModelIdx - index of a subtree (submodel) root which should be
%  replaced by a subtree of the first model
%
% Outputs:
% firstCoModel, secondCoModel - model after crossover

% Extract corresponding submodels
firstSubModel = ExtractSubModel(firstModel, firstModelIdx);
secondSubModel = ExtractSubModel(secondModel,secondModelIdx);

% Replace corresponding submodels
firstCoModel = ReplaceSubModel(firstModel, firstModelIdx, secondSubModel);
secondCoModel = ReplaceSubModel(secondModel, secondModelIdx, firstSubModel);

end
