global trainingData;
global k;

trainingData = load("../data/chickwts_training.csv");
testData = load("../data/chickwts_testing.csv");
k=1;

function food = classify(chickenWeight)
  global trainingData;
  global k;
  knnData = sortrows([trainingData abs(chickenWeight - trainingData(:, 2))],4);
  topk = knnData(1:k,3);
  food = mode(topk);
endfunction

results = arrayfun(@classify, testData(:,2));

function confusionmatrix = confusionmat(observed, predicted)
  uniqueValues = length(unique(observed));
  confusionmatrix = zeros(uniqueValues, uniqueValues);
  for i = 1:length(observed)
    confusionmatrix(observed(i)+1, predicted(i)+1) += 1;
  endfor
endfunction

C = confusionmat(testData(:,3), results)

accuracy = sum(diag(C)) / sum(sum(C))