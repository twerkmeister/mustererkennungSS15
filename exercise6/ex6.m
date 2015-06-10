data = dlmread("../data/klausur.txt", ";");

X = [data(:, 1), ones(rows(data), 1)];
Y = data(:, 2) * 2 - 1;

# a

function w = perzeptron(X, Y)
  w = [0, 0];
  alpha = 0;
  correct = 0;

  while (correct < 20)
    idx = unidrnd(rows(X));
    if (sign(X(idx, :) * w') == Y(idx))
      correct += 1;
    else
      line([0, w(1)], [0, w(2)], "color", [1-alpha,1-alpha,1-alpha]);
      line([w(2), -w(2)], [-w(1), w(1)], "color", [1,1-alpha,1-alpha]);
      w += Y(idx) * X(idx, :);
      alpha += 0.1;
      correct = 0;
    end
  end

  line([0, w(1)], [0, w(2)], "color", [0,0,0], "linewidth", 2);
  line([w(2), -w(2)], [-w(1), w(1)], "color", [1,0,0], "linewidth", 2);
end

scatter(X(:,1), X(:,2));
hold on;
perzeptron(X, Y);      
axis([-2, 2, -2, 2]);
axis("equal");
hold off;

# b

function thresh = linearRegressionThreshold(X, Y)
  w = (inv(X'*X))*X'*Y;
  thresh = -w(2) / w(1);
end

function thresh = perzeptronThreshold(X, Y)
  w = [0, 0];
  correct = 0;

  while (correct < 20)
    idx = unidrnd(rows(X));
    if (sign(X(idx, :) * w') == Y(idx))
      correct += 1;
    else
      w += Y(idx) * X(idx, :);
      correct = 0;
    end
  end

  thresh = -w(2) / w(1);
end

perzeptron = mean(arrayfun(@(n) perzeptronThreshold(X, Y), 1:100));
regression = linearRegressionThreshold(X, Y);
