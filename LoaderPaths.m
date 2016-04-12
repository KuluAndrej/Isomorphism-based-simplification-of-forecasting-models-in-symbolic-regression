function [ data, primitives, models, nlinopt, genopt, pltopt ] = LoaderPaths(PrjFname)
    THISFOLDER = fileparts(mfilename('fullpath'));
    DATAFOLDER = fullfile(THISFOLDER,'data');
    FUNCFOLDER = fullfile(THISFOLDER,'func');
    CODEFOLDER = fullfile(THISFOLDER,'code');
    
    CPLUSPLUSFOLDER = fullfile(THISFOLDER,'cplusplus');    
    
    %CPLUSPLUSCODEFOLDER = fullfile(THISFOLDER,'cplusplus_code');
    REPORTFOLDER  = fullfile(THISFOLDER,'report');
    if ~exist(REPORTFOLDER,'dir'), mkdir(REPORTFOLDER); end
    addpath(FUNCFOLDER);
    addpath(DATAFOLDER);
    addpath(CODEFOLDER);
    addpath(CPLUSPLUSFOLDER);
     
    %addpath(CPLUSPLUSCODEFOLDER );
    %clearFiles();
    [ data, primitives, models, nlinopt, genopt, pltopt ] = InputProjectData( PrjFname, DATAFOLDER );
end


function [] = clearFiles ()
    fileID1 = fopen('tex_table.txt', 'wt');
    fileID2 = fopen('plot.txt', 'wt');
    fileID3 = fopen('Uniqieness checker.txt', 'wt');
    fclose(fileID1);
    fclose(fileID2);
    fclose(fileID3);
end