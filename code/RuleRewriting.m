function model = RuleRewriting( model, rules )
    
    temporalHandle = model.Handle;
    %disp(temporalHandle);
    temporalHandle = handle_reconstructer(temporalHandle);
    unparametred_handle = rule_search(temporalHandle, rules);
    
    [model.Mat, model.Tokens, model.Encoding] = processing_string(unparametred_handle);
    
end

