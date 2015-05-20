function confusionmatrix = confusionmat(observed, predicted)
  uniqueValues = length(unique(observed));
  confusionmatrix = zeros(uniqueValues, uniqueValues);
  for i = 1:length(observed)
    confusionmatrix(observed(i)+1, predicted(i)+1) += 1;
  end
end