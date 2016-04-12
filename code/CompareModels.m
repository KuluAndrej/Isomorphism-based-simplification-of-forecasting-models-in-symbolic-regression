function [number_of_simplifications] = CompareModels(init_model, simplified_model, number_of_simplifications, fid, fid2)
    if strcmp(init_model.Handle, simplified_model.Handle) == 0
        number_of_simplifications = number_of_simplifications + 1;
        %{
        disp(init_model.Handle);
        disp(simplified_model.Handle);
        disp('');
        disp('there goes the simplified model...')
              
        disp([simplified_model.MSE, simplified_model.Error, simplified_model.Control]);
        disp([init_model.MSE, init_model.Error, init_model.Control]);
        disp([init_model.MSE / simplified_model.MSE, init_model.Error / simplified_model.Error, init_model.Control / simplified_model.Control]);
        disp(init_model.FoundParams)
        disp(simplified_model.FoundParams)
        %}
        improvement = [init_model.MSE, simplified_model.MSE, init_model.Error, simplified_model.Error, init_model.Control, simplified_model.Control];
        detailed = [init_model.MSE, simplified_model.MSE, init_model.Error, simplified_model.Error, init_model.Control, simplified_model.Control];
        
        formatspec_improvement = '%.5f %.5f %.5f %.5f %.5f %.5f\n';
        format_spec_detailed = '%s\n%s\n%.5f %.5f %.5f %.5f %.5f %.5f\n';
        
        for_check = (init_model.MSE + simplified_model.MSE) + (init_model.Error + simplified_model.Error) + (init_model.Control + simplified_model.Control);
        
        condition = (for_check<0 || isnan(for_check) || isinf(for_check) || (abs(for_check) < 1e-8) || abs(for_check) > 1e8);
        if ~condition
            fprintf(fid, formatspec_improvement , improvement );
            fprintf(fid2,format_spec_detailed, init_model.Handle, simplified_model.Handle, detailed);
        end
        
    end
    
end