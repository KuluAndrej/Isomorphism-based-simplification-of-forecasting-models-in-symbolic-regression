function [rules] = GetRules()
    
    rules = textscan(fopen('rules.txt'), '%s %s');
    fclose('all'); 
    rules_patterns = rules{:,1};
    rules_replace = rules{:,2};
    
    rules = cell(2 * size(rules_patterns, 1),1);
    for ii = 1:length(rules_patterns) 
        rules{2*ii - 1} = rules_patterns{ii};
        rules{2*ii}     = rules_replace{ii};
    end    
end