function [delta1,delta2] = backProp(eVec, D1, D2)
  % display("backProp")
  % display("====================================")
  % display("eVec")
  % display(eVec)
  % display("D1")
  % display(D1)
  % display("D2")
  % display(D2)
  
  global W2_;
  % display("W2_")
  % display(W2_)
  W2 = W2_(1:rows(W2_)-1,:);
  % display("W2")
  % display(W2)

  delta2 = D2 * eVec'; % 1x1
  delta1 = D1 * W2 * delta2; % 2x1
  % display("delta2")
  % display(delta2)
  % display("delta1")
  % display(delta1)
  % display("====================================")
end