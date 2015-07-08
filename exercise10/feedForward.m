function [predicted, D1, D2, o0_, o1_] = feedForward(o0)
  % display("feedForward")
  % display("====================================")
  global W1_;
  global W2_;
  % display("W1_")
  % display(W1_)
  % display("W2_")
  % display(W2_)
  o0_ = addBias(o0);

  o1 = sigmoid(o0_ * W1_);  %1x2
  D1 = saveDerivatives(o1); %2x2
  o1_ = addBias(o1);

  o2 = sigmoid(o1_ * W2_);  %1x1
  D2 = saveDerivatives(o2); %1x1
  predicted = o2;
  % display("predicted")
  % display(predicted)
  % display("D1")
  % display(D1)
  % display("D2")
  % display(D2)
  % display("o0_")
  % display(o0_)
  % display("o1_")
  % display(o1_)
  % display("====================================")
end