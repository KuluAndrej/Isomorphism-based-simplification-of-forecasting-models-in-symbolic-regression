function [] = analizator()
    A = dlmread('Changes.txt');
    
    B = zeros(size(A,1),3);
    for ii = 1:3
        B(:,ii) = (A(:,2*ii - 1) - A(:,2*ii))./A(:,2*ii - 1);
    end
    find(B(:,1) < 0)'
    
    %B = B(filter(B(:,2)), :);    
    size(B)
    mean(B)
    disp([length(find(B(:,1) == 0)) / size(B,1), length(find(B(:,1) < 0)) / size(B,1), length(find(B(:,1) > 0)) / size(B,1)])
    disp([length(find(B(:,2) == 0)) / size(B,1), length(find(B(:,2) < 0)) / size(B,1), length(find(B(:,2) > 0)) / size(B,1)])
    disp([length(find(B(:,3) == 0)) / size(B,1), length(find(B(:,3) < 0)) / size(B,1), length(find(B(:,3) > 0)) / size(B,1)])
    
    subplot(1,3,1), hist(find(B(:,1) < 0))
    subplot(1,3,2), hist(find(B(:,2) < 0))
    subplot(1,3,3), hist(find(B(:,3) < 0))
    
    
end


function [indices] = filter(vec)
    threshhold1 = prctile(vec, 5);
    threshhold1
    threshhold2 = prctile(vec, 95);    
    threshhold2
    indices = find((vec < threshhold2) & (vec > threshhold1));
    
end