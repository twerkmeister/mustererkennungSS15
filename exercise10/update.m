function update(delta1, delta2, o0_, o1_)
  % display("update")
  % display("====================================")
  % display("delta1")
  % display(delta1)
  % display("delta2")
  % display(delta2)
  % display("o0_")
  % display(o0_)
  % display("o1_")
  % display(o1_)
  global W1_;
  global W2_;
  global alpha;

  % display("W1_")
  % display(W1_)
  % display("W2_")
  % display(W2_)
  % display("alpha")
  % display(alpha)

  update1 = (-alpha * delta1 * o0_)'; % 2x1 x 1x3 = 2x3
  update2 = (-alpha * delta2 * o1_)'; % 1x1 * 1x2 = 1x2

  % display("update1")
  % display(update1)
  % display("update2")
  % display(update2)

  W1_ += update1;
  W2_ += update2;

  % display("W1_")
  % display(W1_)
  % display("W2_")
  % display(W2_)
  % display("====================================")
end