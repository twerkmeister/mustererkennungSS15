data = load("../data/fieldgoal.txt");

X = [data(:, 1) ones(rows(data),1)];
Y = data(:,2);
XforPlot = [(0:100)' ones(101,1)];

theta = [0; 0];
alpha = 10e-7;

function probabilities = p(theta, X)
  probabilities = exp(X*theta);
  probabilities = probabilities ./ (1 + probabilities);
end

for i = 1:100000
  update = X' * (Y - p(theta, X));
  theta = theta + alpha * update;
  if(mod(i, 25000) == 0)
    e = sum(abs(Y - p(theta,X)));
    disp(sprintf("Sum of errors after %d iterations: %f", i, e));

    probabilities = p(theta, XforPlot);
    subplot(2,2,i/25000);
    plot(XforPlot(:,1), probabilities, "linewidth", 3);
    title(sprintf("Probabilities after %d iterations; sum of errors: %f", i, e), "FontSize", 20);
    xlabel("distance to goal", "FontSize", 20);
    ylabel("probability of success", "FontSize", 20);
    ylim([0 1]);
  end
end
