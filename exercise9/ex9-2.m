k = 4;
global alpha = 0.3;
training = load("../data/pendigits-training.txt");
testing = load("../data/pendigits-testing.txt");
global OutN = 10;
global W1_ = rand(17,k);
global W2_ = rand(k+1, OutN);

function [X,Y] = splitExamples(examples)
  X = examples(:,1:columns(examples)-1) / 100;
  Y = examples(:,columns(examples));
end

function yVec = solutionToVector(y)
  global OutN;
  yVec = zeros(1, OutN);
  yVec(y+1) = 1; 
end

function y = vectorToSolution(y)
  [maxEl, i] = max(y);
  y = i - 1;
end

[X_train,Y_train] = splitExamples(training);
[X_test,Y_test] = splitExamples(testing);

for round = 1:100
  for i = 1:rows(X_train)
    o0 = X_train(i,:);
    [predicted,D1,D2,o0_,o1_] = feedForward(o0);
    observed = solutionToVector(Y_train(i));
    [E,eVec] = calculateError(predicted, observed);
    [delta1, delta2] = backProp(eVec, D1, D2);
    update(delta1, delta2, o0_, o1_)
  end
  display(sprintf("round: %d", round))
end


testing_predicted = zeros(rows(X_test));
for i = 1:rows(X_test)
  o0 = X_test(i,:);
  [predicted,D1,D2,o0_,o1_] = feedForward(o0);
  observed = solutionToVector(Y_test(i));
  [E,eVec] = calculateError(predicted, observed);
  testing_predicted(i) = vectorToSolution(predicted);
end

C = confusionmat(Y_test,testing_predicted)
accuracy = evaluate(C)