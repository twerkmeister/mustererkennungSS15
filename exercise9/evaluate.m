function accuracy = evaluate(C) 
  accuracy = sum(diag(C)) / sum(sum(C));
end