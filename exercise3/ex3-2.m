trainingData = load("../data/pendigits-training.txt");
testData = load("../data/pendigits-testing.txt");

trainingDataFeatures = trainingData(:, 1:16);
trainingDataLabels = trainingData(:, 17);

testDataFeatures = testData(:, 1:16);
testDataLabels = testData(:, 17);

covariance = cov(trainingDataFeatures);

[eigenVectors, eigenValueMatrix] = eig(covariance);

eigenValues = diag(eigenValueMatrix);


[_,sortKey] = sort(eigenValues, "descend");

%print main component
disp("the main component:")
disp(eigenVectors(:, sortKey(1)))

for numDimensions = 1:16
  base = eigenVectors(:, sortKey(1:numDimensions));

  transformedTrainingDataFeatures = trainingDataFeatures * base;
  transformedTestDataFeatures = testDataFeatures * base;

  [C, accuracy] = classifyBayes(transformedTrainingDataFeatures, trainingDataLabels, transformedTestDataFeatures, testDataLabels);

  disp(sprintf("choosing the %d best dimensions, accuracy is %f", numDimensions, accuracy))
end

