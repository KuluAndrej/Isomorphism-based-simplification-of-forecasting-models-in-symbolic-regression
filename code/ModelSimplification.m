function [model_to_simplify, init_model] = ModelSimplification( init_model, rules, data, nlinopt)
    
    model_to_simplify = RuleRewriting( init_model, rules );
    model_to_simplify = DimensionalityReduction( model_to_simplify );
        
end