function [ ] = analysis_random_superpositions(PrjFname)

warning off
global PLTOPTSFIGNUM
PLTOPTSFIGNUM = 1;

% Add paths and initialize dir variables
if nargin < 0001
    PrjFname = 'demo.prj.txt';
end
[ data, primitives, models, nlinopt, genopt, pltopt ] = LoaderPaths(PrjFname);

data = DataPreparation(data);
rules = GetRules();

% file for storing fractions of simplifiable superpositions among randomly
% generated
fileidRF = fopen('Analysis/random_fractions.txt', 'a+');

fileid = fopen(['Changings/Changes', num2str(1) '.txt'], 'w');
fileid2 = fopen(['Changings/handles', num2str(1) '.txt'], 'w');
 


iters = 200;
pop_size_on_iter = 50;

for str_com = 6:25
    str_com
    number_of_simplifications = 0;
    for ii = 1:iters
        population = CreateRandomPopulation(pop_size_on_iter, primitives, 2, str_com);
        % assign some dummy values
        for modelIdx = 1:length(population)
            population{modelIdx}.MSE = 1;
            population{modelIdx}.Error = 1;
            population{modelIdx}.Control = 1;                         
        end
        [~, number_of_simplifications] = SimplifyPopulation( population, rules, data, nlinopt, number_of_simplifications, fileid, fileid2 );
    end
    [str_com, number_of_simplifications / (iters * pop_size_on_iter)]
    fprintf(fileidRF, '%d ', number_of_simplifications / (iters * pop_size_on_iter));
end

close all;

%{
func = str2func(population{1}.Handle);
plot(data.X, data.Y)
hold on
plot(data.X, arrayfun(func, data.X))
hold off
%}
%PlotStruct(str2func(population{1}.Handle), population{1}.FoundParams, data.X, data.Y, pltopt);
%Population2TeX(population, data.X, data.Y, REPORTFOLDER, 'ListOfObtainedModels.tex', pltopt);
%fprintf('Handle = %s;\nMSE = %d;\n Error = %d, numbModel = %d\n', population{1}.Handle, population{1}.MSE, population{1}.Error,numbModel)


end

