function [] = analysis_final_models_MVR()
%analysis_hists
% Anilyzes the final models selected by MVR with/without simplification
% 
% Inputs:
%  -
%
% Outputs:
%  average values of MSE and \mathcal{S} for top-1 model and top-20 models


number_of_launches = 100;
mse_simpl = [];
mse_20_simpl = [];
error_simpl = [];
error_20_simpl = [];
for ii = 1:number_of_launches
    [mse_top1,mse_top20,error_top1,error_top20] = main('demo.prj.txt', 1);
    mse_simpl        = [mse_simpl, mse_top1];
    mse_20_simpl      = [mse_20_simpl, mse_top20];
    error_simpl      = [error_simpl, error_top1];
    error_20_simpl    = [error_20_simpl, error_top20];
end

disp('for simplification')
mean(mse_simpl)
mean(mse_20_simpl)
mean(error_simpl)
mean(error_20_simpl)



mse_ = [];
mse_20_ = [];
error_ = [];
error_20 = [];
for ii = 1:number_of_launches
    [mse_top1,mse_top20,error_top1,error_top20] = main_without_simpl('demo.prj.txt', 1);
    mse_        = [mse_, mse_top1];
    mse_20_      = [mse_20_, mse_top20];
    error_      = [error_, error_top1];
    error_20    = [error_20, error_top20];
end

disp('without simplification')
mean(mse_)
mean(mse_20_)
mean(error_)
mean(error_20)


