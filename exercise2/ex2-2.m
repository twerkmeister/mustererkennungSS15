global trainingData;
global binSize;
global apriori;

trainingData = load("../data/chickwts_training.csv");
testData = load("../data/chickwts_testing.csv");

# 2a
means = arrayfun(@(n) mean(trainingData(trainingData(:,3)==n,2)), [0:5])
vars = arrayfun(@(n) var(trainingData(trainingData(:,3)==n,2)), [0:5])

apriori = arrayfun(@(n) sum(trainingData(:,3)==n) / rows(trainingData), [0:5])

# 2b
maxWeight = max(trainingData(:,2));
binSize = 20;
minBin = floor(minWeight/binSize);
maxBin = floor(maxWeight/binSize);
bins = [minBin:maxBin];

function res = aposteriori(bin, food)
  global trainingData;
  global apriori;
  global binSize;

  evidence = sum(floor(trainingData(:,2)/binSize)==bin) / rows(trainingData);
  weightAndFoodCount = sum(floor(trainingData(:,2)/binSize)==bin & (trainingData(:,3)==food));
  foodCount = sum(trainingData(:,3)==food);
  likelihood = weightAndFoodCount / foodCount;
  res = apriori(food+1) * likelihood / evidence;
endfunction

aposterioriData = transpose([arrayfun(@(bin) aposteriori(bin, 0), bins);
		arrayfun(@(bin) aposteriori(bin, 1), bins);
		arrayfun(@(bin) aposteriori(bin, 2), bins);
		arrayfun(@(bin) aposteriori(bin, 3), bins);
		arrayfun(@(bin) aposteriori(bin, 4), bins);
		arrayfun(@(bin) aposteriori(bin, 5), bins)]);

#bar(aposterioriData, "stacked");
#legend("horsebean", "linseed", "soybean", "sunflower", "meatmeal", "casein");

# 2c
results = arrayfun(@(chickenWeight) [[val, idx] = max(aposterioriData(floor(chickenWeight/binSize)-minBin+1,:)), idx](2)-1, testData(:,2));

function confusionmatrix = confusionmat(observed, predicted)
  uniqueValues = length(unique(observed));
  confusionmatrix = zeros(uniqueValues, uniqueValues);
  for i = 1:length(observed)
    confusionmatrix(observed(i)+1, predicted(i)+1) += 1;
  endfor
endfunction

C = confusionmat(testData(:,3), results)

accuracy = sum(diag(C)) / sum(sum(C))
