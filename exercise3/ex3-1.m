trainingData = load("../data/pendigits-training.txt");
testData = load("../data/pendigits-testing.txt");

trainingDataFeatures = trainingData(:, 1:16);
trainingDataLabels = trainingData(:, 17);
testDataFeatures = testData(:, 1:16);
testDataLabels = testData(:, 17);

[C, accuracy] = classifyBayes(trainingDataFeatures, trainingDataLabels, testDataFeatures, testDataLabels)