function [ ] = plot_builder()

warning off
global PLTOPTSFIGNUM
PLTOPTSFIGNUM = 1;

if nargin < 1
    PrjFname = 'config_for_compared_models_to_plot.txt';
end

THISFOLDER = fileparts(mfilename('fullpath'));
DATAFOLDER = fullfile(THISFOLDER,'data');
FUNCFOLDER = fullfile(THISFOLDER,'func');
CODEFOLDER = fullfile(THISFOLDER,'code');
REPORTFOLDER  = fullfile(THISFOLDER,'report');
if ~exist(REPORTFOLDER,'dir'), mkdir(REPORTFOLDER); end
addpath(FUNCFOLDER);
addpath(CODEFOLDER);

[ data, primitives, models, nlinopt, genopt, pltopt ] = InputProjectData( PrjFname, DATAFOLDER );

population = CreatePopulation(models.Models, models.InitParams, primitives);
population = LearnPopulationOld(population, data.X, data.Y, nlinopt, pltopt );


for ii = 1:length(population)
    disp(population{ii}.Handle)
    abs(population{ii}.MSE)
    figure(ii)
    PlotStruct(str2func(population{ii}.Handle), population{ii}.FoundParams, data.X, data.Y, pltopt);
end

end


