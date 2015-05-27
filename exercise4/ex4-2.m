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

global Y = data(:, columns(data));
global pset = powerset(1:columns(data)-1);

function minerror = minimalError(n)
	global pset;
	global data;
	global Y;

	indices = cellfun(@(x) length(x)==n, pset);
	variableSets = pset(indices);

	minerror = Inf;

	for i = 1:length(variableSets)
		X = [ones(length(data), 1) data(:,variableSets{i})];
		theta = linearRegression(X, Y);
		predicted = predict(theta, X);
		minerror = min(regressionError(predicted, Y), minerror);
	end
	# minerror /= nchoosek(columns(data)-1, n);
end

results = arrayfun(@minimalError, 1:columns(data)-1);

plot(results, "-d")