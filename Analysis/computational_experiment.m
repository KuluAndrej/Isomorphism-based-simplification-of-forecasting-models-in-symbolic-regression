function [] = computational_experiment()

%files = {'50.1sv1(20.15.30) (excellent dataset)', '50.1sv2(20.15.30) (MSE Control do not change)', '50.1sv3(20.15.30) (MSE Control do not change)', '50.1sv4(20.15.30) (Control tend bad)', '50.1sv5(20.15.30) (Tend bad)', '50.1sv5(20.15.30) (Very good)'};
files = {'50.2sv1(20.15.30) (Good dataset)', '50.2sv2(20.15.30) (Good dataset)', '50.2sv3(20.15.30) (Norm dataset)', '50.2sv4(20.15.30) (Control bad tend)', '50.2sv5(20.15.30) (Bad dataset)', '50.2sv6(20.15.30) (Neutral dataset)'};

%appendix = '/home/kuluandrej/cafedra2013-2014/Mycode/backup/Final_results_3/50.1sv1/';
appendix = '/home/kuluandrej/cafedra2013-2014/Mycode/DataChanged/';
%appendix = '/home/kuluandrej/cafedra2013-2014/Mycode/DataSimpl/';

B = zeros(50,0);
C = zeros(0,10);
A = [];
NumFiles = 20;
NumFile = 22;
for ii = 1:31
    ii
    
    A = dlmread([appendix, 'evolution', num2str(ii),'.txt']);
    if (A(1,2) == Inf)
        A(1,:) = [];
    end
    B = [B, A(:,2)];
    %{
    A = dlmread([appendix, 'Changes', num2str(ii),'.txt']);
    C = [C; A];
    %}
    
end

size(C,1)
D = ones(size(C,1),5);

for ii = 1:5
        D(:,ii) = (C(:,2*ii - 1) - C(:,2*ii))./abs(C(:,2*ii - 1));
end

find(D(:,1) > 0)';
size(B)






b1 = D(:,2);
b1 = b1(filter(D(:,2)));
b2 = D(:,5);
b2 = b2(filter(D(:,5)));

font_size = 20;
%{
b1 = b1(find(b1 > -2 & b1 < 2))
h = figure; hold('on');
subplot(1,2,1), hist([100*b1],100) 
hold on
line([0 0], get(gca,'ylim'), 'Color','g', 'LineWidth',2, 'LineStyle', '--');
t = title('Histogram of relative error change', 'FontSize', font_size, 'FontName', 'Times');
xlabel('Percentage of improvement, \%', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Number of models', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', font_size, 'FontName', 'Times')

subplot(1,2,2), hist([100*b2],100, 'r-')
hold on
line([0 0], get(gca,'ylim'), 'Color','g', 'LineWidth',2, 'LineStyle', '--');
t = title('Histogram of relative AIC change', 'FontSize', font_size, 'FontName', 'Times');
xlabel('Percentage of improvement, \%', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Number of models', 'FontSize', font_size, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', font_size, 'FontName', 'Times')
%saveas(h,'hists.eps', 'psc2');
%}
%{
subplot(2,2,1), hist(D(:,1),100)
subplot(2,2,2), hist(D(:,2),100)
subplot(2,2,3), hist(D(:,3),100)
subplot(2,2,4), hist(D(:,5),100)
%}

dlmwrite('percentage_1.txt', B);
dlmwrite('percentage_c_1.txt', C);

figure(1)
hist(B(1,:))
B(1,:)
std(B')
B
h = figure(2); hold('on');
plot(mean(B, 2),'r-', 'Linewidth', 2); 
errorbar(mean(B, 2), std(B'))
axis('tight');
xlabel('Iteration', 'FontSize', 20, 'FontName', 'Times', 'Interpreter','latex');
ylabel('Simplifiable superpositions, fraction', 'FontSize', 20, 'FontName', 'Times', 'Interpreter','latex');
set(gca, 'FontSize', 20, 'FontName', 'Times');
%saveas(h,'percentage_options.eps', 'psc2');


end


function [indices] = filter(vec)
    threshhold1 = prctile(vec, 10);
    
    threshhold2 = prctile(vec, 90);    
    indices = find((vec < threshhold2) & (vec > threshhold1));
    
end