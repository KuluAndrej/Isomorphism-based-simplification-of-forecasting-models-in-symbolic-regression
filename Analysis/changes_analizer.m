jj = 1;
A = dlmread('percentage_c_1.txt');
B = ones(size(A,1),size(A,2) / 2);
size(B)
B(:,1) = (A(:,1) - A(:,2))./A(:,1);
B(:,2) = (A(:,3) - A(:,4))./A(:,3);
B(:,3) = (A(:,5) - A(:,6))./A(:,5);

disp([length(find(B(:,1) == 0)) / size(B,1), length(find(B(:,1) < 0)) / size(B,1), length(find(B(:,1) > 0)) / size(B,1)])
disp([length(find(B(:,2) == 0)) / size(B,1), length(find(B(:,2) < 0)) / size(B,1), length(find(B(:,2) > 0)) / size(B,1)])
disp([length(find(B(:,3) == 0)) / size(B,1), length(find(B(:,3) < 0)) / size(B,1), length(find(B(:,3) > 0)) / size(B,1)])

mean(B)