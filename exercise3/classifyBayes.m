function [C, accuracy] = classifyBayes(trainingDataFeatures, trainingDataLabels, testDataFeatures, testDataLabels)
  pkg load statistics

  numDigits = 10;
  groupedByDigit = cell(1,numDigits);
  means = cell(1, numDigits);
  covs = cell(1, numDigits);
  numFeatures = columns(trainingDataFeatures);

  for i = 1:numDigits
    groupedByDigit{i} = trainingDataFeatures(trainingDataLabels==i-1,1:numFeatures);
    means{i} = mean(groupedByDigit{i});
    covs{i} = cov(groupedByDigit{i});
  end


  resultMatrix = cell2mat(arrayfun(@(n) mvnpdf(testDataFeatures, means{n}, covs{n}), 1:10, "UniformOutput", false));

  [prob, digit] = max(resultMatrix');

  classification = digit' - 1;

  C = confusionmat(testDataLabels, classification);

  accuracy = sum(diag(C)) / sum(sum(C));
end