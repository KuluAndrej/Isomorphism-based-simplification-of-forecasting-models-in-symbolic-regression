function [mse_top1,mse_top20,error_top1,error_top20] = main(PrjFname, number_of_MVR_launches)
%main
% Launches MVR and collect the data for plots
% 
% Inputs:
% PrjFname - name of the file containing MVR configures
%
% Outputs:
%  relative change in MSE, MSE_Control and error function ->
%  -> 'Changings/Changes(ii).txt'
%  handles of initial and simplified v-s of superposition -> 
%  -> 'Changings/handles(ii).txt'
%  percentage of simplifiable superpositions generated by i-th iteration -> 
%  -> 'Changings/evolution(ii).txt'
%  mse_top1         - MSE of the best selected superposition
%  mse_top20        - average MSE among 20 selected superpositions
%  error_top1       - \mathcal{S} of the best selected superposition 
%  error_top20      - average \mathcal{S} among 20 selected superpositions

warning off
global PLTOPTSFIGNUM
PLTOPTSFIGNUM = 1;

% Add paths and initialize dir variables
if nargin < 0001
    PrjFname = 'demo.prj.txt';
    number_of_MVR_launches = 50;
end
[ data, primitives, models, nlinopt, genopt, pltopt ] = LoaderPaths(PrjFname);

data = DataPreparation(data);
rules = GetRules();


for jj = 1:number_of_MVR_launches
    
fileid = fopen(['Changings/Changes', num2str(jj) '.txt'], 'w');
fileid2 = fopen(['Changings/handles', num2str(jj) '.txt'], 'w');
fileid3 = fopen(['Changings/evolution', num2str(jj) '.txt'], 'w');
 
number_of_simplifications = 0;

population = CreatePopulation(models.Models, models.InitParams, primitives);
population = LearnPopulation( population, data, nlinopt );
[population, number_of_simplifications] = SimplifyPopulation( population, rules, data, nlinopt, number_of_simplifications, fileid, fileid2 );


tic

  
numbModel = 0;  

disp('start calculations...')
for itr = 1 : genopt.MAXCYCLECOUNT
    fprintf(fileid3, '%d %d\n' , [itr number_of_simplifications / numbModel]);    
    [itr number_of_simplifications / numbModel]
    populationCO = CrossoverPopulation(population, genopt.CROSSINGAMOUNT);
    populationMU = MutationPopulation(population, primitives, size(data.X, 2), genopt.MUTATIONAMOUNT);
    populationRA = CreateRandomPopulation(5, primitives, 2, 6 + randi(7));
    
    numbModel = numbModel + length(populationCO) + length(populationMU) + length(populationRA);
    
    populationCO = LearnPopulation( populationCO, data, nlinopt );
    populationMU = LearnPopulation( populationMU, data, nlinopt );
    populationRA = LearnPopulation( populationRA, data, nlinopt );
    
    
    [populationCO, number_of_simplifications] = SimplifyPopulation( populationCO, rules, data, nlinopt, number_of_simplifications, fileid, fileid2 );
    [populationMU, number_of_simplifications] = SimplifyPopulation( populationMU, rules, data, nlinopt, number_of_simplifications, fileid, fileid2 );
    [populationRA, number_of_simplifications] = SimplifyPopulation( populationRA, rules, data, nlinopt, number_of_simplifications, fileid, fileid2 );    
    
        
    population = [population, populationCO, populationMU, populationRA];
    population   = SelectBestPopulationElements(population, genopt.BESTELEMAMOUNT);    
    PrintPopulation(population);
end;
t = toc;
t

fprintf(fileid3, '%d %d\n' , numbModel, number_of_simplifications / numbModel);     

fclose(fileid);
end
disp('...done')
end

