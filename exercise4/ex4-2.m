global data = dlmread("../data/winequality-red.txt", ";");

function theta = linearRegression(X, Y)
  theta = (inv(X'*X))*X'*Y;
end

function predicted = predict(theta, X)
  predicted = X * theta;
end

function error = regressionError(X, Y)
  error = sum((X - Y).**2);
end

Y = data(:, columns(data));
pset = powerset(1:columns(data)-1);
resultPoints = [];

# skipping empty set
for i = 2:length(pset)
	set = pset{i};
	X = [ones(length(data), 1) data(:,set)];
	theta = linearRegression(X, Y);
	predicted = predict(theta, X);
	resultPoints = [resultPoints; [length(set) regressionError(predicted, Y)]];
end

scatter(resultPoints(:,1), resultPoints(:,2));
