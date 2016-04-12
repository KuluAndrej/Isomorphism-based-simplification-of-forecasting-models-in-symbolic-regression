function [] = analysis_hists()
%analysis_hists
% Collect data required for histograms of relative changes and build this
% hists
% 
% Inputs:
%  -
%
% Outputs:
%  histograms of relative changes of \mathcal{S} and Akaike information
%  criterion
main('demo.prj.txt', 50);
appendix = 'Changings/';


evolutions = zeros(50,0);
changes = zeros(0,10);
A = [];
for ii = 1:50
    A = dlmread([appendix, 'evolution', num2str(ii),'.txt']);
    if (A(1,2) == Inf)
        A(1,:) = [];
    end
    evolutions = [evolutions, A(:,2)];
    
    A = dlmread([appendix, 'Changes', num2str(ii),'.txt']);
    changes = [changes; A];
end

relativeChanges = ones(size(changes,1),5);
for ii = 1:5
    relativeChanges(:,ii) = (changes(:,2*ii - 1) - changes(:,2*ii))./abs(changes(:,2*ii - 1));
end



errorChange = relativeChanges(:,2);
errorChange = errorChange(filter(relativeChanges(:,2)));
aicChange = relativeChanges(:,5);
aicChange = aicChange(filter(relativeChanges(:,5)));

font_size = 20;


h1 = figure(1); hold('on');
subplot(1,2,1), hist([100*errorChange],100) 
hold on
line([0 0], get(gca,'ylim'), 'Color','g', 'LineWidth',2, 'LineStyle', '--');
t = title('Histogram of relative error change', 'FontSize', font_size, 'FontName', 'Times');
xlabel('Percentage of improvement, \%', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Number of models', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', font_size, 'FontName', 'Times')

subplot(1,2,2), hist([100*aicChange],100, 'r-')
hold on
line([0 0], get(gca,'ylim'), 'Color','g', 'LineWidth',2, 'LineStyle', '--');
t = title('Histogram of relative AIC change', 'FontSize', font_size, 'FontName', 'Times');
xlabel('Percentage of improvement, \%', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Number of models', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', font_size, 'FontName', 'Times')
saveas(h1,'hists.eps', 'psc2');



h2 = figure(2); hold('on');
plot(mean(evolutions, 2),'r-', 'Linewidth', 2); 
errorbar(mean(evolutions, 2), std(evolutions'))
axis('tight');
xlabel('Iteration', 'FontSize', 20, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Simplifiable superpositions, fraction', 'FontSize', 20, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 20, 'FontName', 'Times');
saveas(h2,'percentage_options.eps', 'psc2');
end


function [indices] = filter(vec)
    threshhold1 = prctile(vec, 2.5);
    
    threshhold2 = prctile(vec, 97.5);    
    indices = find((vec < threshhold2) & (vec > threshhold1));
    
end

