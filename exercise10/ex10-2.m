k = 16;
data = load("../data/pendigits-training.txt");
global OutN = 10;
global W1_ = zeros(17,k) - 0.5;
% global W1_ = rand(17,k);
% global W2_ = rand(k+1, OutN);
global W2_ = zeros(k+1, OutN) - 0.5;

global alpha1 = zeros(size(W1_)) + 1;
global alpha2 = zeros(size(W2_)) + 1;

global d = 1;
global u = 1;

alphaMax = 1;
alphaMin = 1;

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

training = data(1:60, :);
validation = data(61:90, :);

[X_train,Y_train] = splitExamples(training);
[X_test,Y_test] = splitExamples(validation);

lastErrorDerivative1 = zeros(size(W1_));
lastErrorDerivative2 = zeros(size(W2_));

iteration = 0;
do
  iteration += 1;

  trainingError = 0;
  testError = 0;

  gradient1 = zeros(size(W1_));
  gradient2 = zeros(size(W2_));
  errorDerivative1 = zeros(size(W1_));
  errorDerivative2 = zeros(size(W2_));

  for i = 1:rows(X_train)
    o0 = X_train(i,:);
    [predicted,D1,D2,o0_,o1_] = feedForward(o0);
    observed = solutionToVector(Y_train(i));
    [E,eVec] = calculateError(predicted, observed);
    trainingError += E;

    [delta1, delta2] = backProp(eVec, D1, D2);

    % display(delta2)

    errorDerivative1 += (delta1 * o0_)';
    errorDerivative2 += (delta2 * o1_)';

    gradient1 += -alpha1 .* abs((delta1 * o0_))';
    gradient2 += -alpha2 .* abs((delta2 * o1_))';
  end

  for i = 1:rows(X_test)
    o0 = X_test(i,:);
    [predicted,D1,D2,o0_,o1_] = feedForward(o0);
    observed = solutionToVector(Y_test(i));
    [E,eVec] = calculateError(predicted, observed);
    testError += E;
  end


  % trainingError = trainingError / rows(X_train);
  % testError = testError / rows(X_test);

  errorProduct1 = errorDerivative1 .* lastErrorDerivative1;
  errorProduct2 = errorDerivative2 .* lastErrorDerivative2;

  alpha1 = ((errorProduct1 > 0) .* min(alpha1 * u, alphaMax)) + ((errorProduct1 < 0) .* max(alpha1 * d, alphaMin)) + ((errorProduct1 == 0) .* alpha1);
  alpha2 = ((errorProduct2 > 0) .* min(alpha2 * u, alphaMax)) + ((errorProduct2 < 0) .* max(alpha2 * d, alphaMin)) + ((errorProduct2 == 0) .* alpha2);

  % display(errorProduct1)
  display(sprintf("Iteration: %d \n================== \nTrainingerror: %f \nTesterror: %f", iteration, trainingError, testError));
  W1_ += gradient1;
  W2_ += gradient2;
  lastErrorDerivative1 = errorDerivative1;
  lastErrorDerivative2 = errorDerivative2;
until testError > trainingError
% until iteration > 100