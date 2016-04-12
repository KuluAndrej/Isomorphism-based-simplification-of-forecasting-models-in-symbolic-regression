function [population, number_of_simplifications] = SimplifyPopulation(population, rules, data, nlinopt, number_of_simplifications, fileid, fileid2)
    for modelIdx = 1 : length(population)
        if (population{modelIdx}.MSE ~= Inf)
            
            if (length(population{modelIdx}.Tokens) > 1)
                [simplified_model, population{modelIdx}] = ModelSimplification( population{modelIdx}, rules, data, nlinopt );
                
                number_of_simplifications = CompareModels( population{modelIdx}, simplified_model, number_of_simplifications, fileid, fileid2 );
                population{modelIdx} = simplified_model;
            end                        
        end
    end
end