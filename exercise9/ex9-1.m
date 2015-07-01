global possibleInputs = [0,0;0,1;1,0;1,1];
global alpha = 10e-6;

global W1_ = rand(3,2);
global W2_ = rand(3,1);

function sample = sampleInput()
  global possibleInputs
  sample = possibleInputs(randi(length(possibleInputs)),:);
end

function biasAdded = addBias(v)
  biasAdded = [v 1];
end

function solution = solve(sample)
  solution = xor(sample(1), sample(2));
end

function [E,eVec] = calculateError(predicted, observed)
  eVec = (predicted - observed);
  E = sum(0.5 * eVec^2);
end

function derivativeMatrix = saveDerivatives(ox)
  derivativeMatrix = diag(ox .* (1-ox));
end

function [predicted, D1, D2, o0_, o1_] = feedForward(o0)
  global W1_;
  global W2_;
  o0_ = addBias(o0);

  o1 = sigmoid(o0_ * W1_);  %1x2
  D1 = saveDerivatives(o1); %2x2
  o1_ = addBias(o1);

  o2 = sigmoid(o1_ * W2_);  %1x1
  D2 = saveDerivatives(o2); %1x1
  predicted = o2;
end

function [delta1,delta2] = backProp(eVec, D1, D2)
  global W2_;
  W2 = W2_(1:rows(W2_)-1,:);

  delta2 = D2 * eVec; % 1x1
  delta1 = D1 * W2 * delta2; % 2x1
end

function update(delta1, delta2, o0_, o1_)
  global W1_;
  global W2_;
  global alpha;

  update1 = (-alpha * delta1 * o0_)';
  update2 = (-alpha * delta2 * o1_)';
  W1_ += update1;
  W2_ += update2;
end

function test()
  global possibleInputs
  for i = 1:rows(possibleInputs)
    o0 = possibleInputs(i,:);
    [predicted,D1,D2,o0_,o1_] = feedForward(o0);
    display(o0)
    display(predicted)
  end
end

for i = 1:10000
  o0 = sampleInput();
  [predicted,D1,D2,o0_,o1_] = feedForward(o0);
  observed = solve(o0);
  [E,eVec] = calculateError(predicted, observed);
  [delta1, delta2] = backProp(eVec, D1, D2);
  update(delta1, delta2, o0_, o1_)
  
  % display(W1_);
  % display(W2_);
  % display(sprintf("Error in Round %d: %f", i, E));
end

display(W1_);
display(W2_);
test()