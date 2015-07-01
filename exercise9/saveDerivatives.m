function derivativeMatrix = saveDerivatives(ox)
  % display("saveDerivatives")
  % display("====================================")
  % display("ox")
  % display(ox)
  derivativeMatrix = diag(ox .* (1-ox));
  % display("derivativeMatrix")
  % display(derivativeMatrix)
  % display("====================================")
end