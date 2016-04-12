function [population] = CheckForUniqueness(population)
    handles = cellfun(@(x) {x.Handle}, population);
    indecesToRemain = unique_check(handles) + 1;
    population = population(indecesToRemain);    
end