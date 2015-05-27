data = load("../data/fish.txt");

X = [ones(rows(data), 1) data(:, [2,3])];
Y = data(:, 4);

theta = (inv(X'*X))*X'*Y;

predicted = X * theta;


meshX = linspace(0, 200, 10);
meshY = linspace(25,31, 10);
[XX, YY] = meshgrid(meshX,meshY);
ZZ = theta(1) + theta(2)*XX + theta(3)*YY;

corners = [1, 0, 25;
           1, 0, 31;
           1, 200, 31;
           1, 200, 25];

cornersZ = corners * theta;

coordinates = [corners(:, [2,3]) cornersZ];


scatter3(X(:,2), X(:,3), Y);
hold on;
scatter3(X(:,2), X(:,3), predicted, "r", "o");
mesh(XX,YY,ZZ);
hidden("off");

errorX = [X(:,2)'; X(:,2)'];
errorY = [X(:,3)'; X(:,3)'];
errorZ = [Y'; predicted'];

plot3(errorX, errorY, errorZ, ":r", "linewidth", 2);


