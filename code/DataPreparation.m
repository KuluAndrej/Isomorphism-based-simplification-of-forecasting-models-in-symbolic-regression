function [data, encodings] = DataPreparation(data)

x = data.X;
%x = x(1:1000);
y = data.Y;
%y = y(1:1000);
sizeX = size(x,1);
sizeXtest = round(sizeX / 3) - 1;
indecesXtest = 3 * [1 : sizeXtest];
indecesXlearn = setdiff(1:sizeX, indecesXtest);

data.Xtest = x(indecesXtest,:);
data.X = x(indecesXlearn,:);

data.Ytest  = y(indecesXtest,:);
data.Y = y(indecesXlearn,:);



end
