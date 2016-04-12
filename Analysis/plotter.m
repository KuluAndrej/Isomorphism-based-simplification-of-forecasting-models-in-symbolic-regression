option = 'random'

if strcmp(option,'random')
    h = figure; hold('on');
    b= [2.178000e-01 2.492000e-01 2.870000e-01 3.209000e-01 3.456000e-01 3.666000e-01 4.025000e-01 4.232000e-01 4.512000e-01 4.771000e-01 4.967000e-01 5.311000e-01 5.517000e-01 5.660000e-01 5.873000e-01 6.037000e-01 6.260000e-01 6.332000e-01 6.557000e-01 6.706000e-01 ];
    
    plot([6:(6+length(b)-1)], b,'r-', 'Linewidth', 2); 
    axis('tight');
    xlabel('Structural complexity, $\phi(f)$', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    ylabel('SImplified superpositions, fraction', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    set(gca, 'FontSize', 14, 'FontName', 'Times')
    saveas(h,'plot_random_models.eps', 'psc2');
end

if strcmp(option,'mvr_evolution')
    h = figure; hold('on');
    plot([ 0.3357    0.3833    0.3730    0.3714    0.3714    0.3631    0.3667    0.3687    0.3722    0.3717    0.3686    0.3649    0.3614],'r-', 'Linewidth', 2); 
    axis('tight');
    xlabel('Structural complexity, $\phi(f)$', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    ylabel('Fraction', 'FontSize', 14, 'FontName', 'Times', 'Interpreter','latex');
    set(gca, 'FontSize', 14, 'FontName', 'Times')
    saveas(h,'plot_random_models.eps', 'psc2');
end