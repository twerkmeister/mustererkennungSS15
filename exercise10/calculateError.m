function [E,eVec] = calculateError(predicted, observed)
  % display("calculateError")
  % display("====================================")
  % display("predicted")
  % display(predicted)
  % display("observed")
  % display(observed)
  eVec = (predicted - observed);
  E = sum(0.5 * eVec.^2);
  % display("eVec")
  % display(eVec)
  % display("E")
  % display(E)
  % display("====================================")
end