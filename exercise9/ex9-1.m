global possibleInputs = [0,0;0,1;1,0;1,1];
global alpha = 0.3;

global W1_ = rand(3,2);
global W2_ = rand(3,1);

function sample = sampleInput()
  % display("sampleInput")
  % display("====================================")
  global possibleInputs
  % display("possibleInputs")
  % display(possibleInputs)
  sample = possibleInputs(randi(length(possibleInputs)),:);
  % display("sample")
  % display(sample)
  % display("====================================")
end

function solution = solve(sample)
  % display("solve")
  % display("====================================")
  % display("sample")
  % display(sample)
  solution = xor(sample(1), sample(2));
  % display("solution")
  % display(solution)
  % display("====================================")
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

for i = 1:20000
  o0 = sampleInput();
  [predicted,D1,D2,o0_,o1_] = feedForward(o0);
  observed = solve(o0);
  [E,eVec] = calculateError(predicted, observed);
  [delta1, delta2] = backProp(eVec, D1, D2);
  update(delta1, delta2, o0_, o1_)
  
  %display(W1_);
  %display(W2_);
  %display(sprintf("Error in Round %d: %f", i, E));
end

display(W1_);
display(W2_);
test()

