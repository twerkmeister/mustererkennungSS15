data = load("../data/titanic.csv");

casulties = data(data(:,6)==0,:);
survivors = data(data(:,6)==1,:);

subplot(2,4,1)
hist(casulties(:,2), [1,2,3])
title("casulties ~ class")

subplot(2,4,2)
hist(casulties(:,3), [0,1])
title("casulties ~ gender")

subplot(2,4,3)
hist(casulties(:,4))
title("casulties ~ age")

subplot(2,4,4)
hist(casulties(:, 5))
title("casulties ~ ticket price")

subplot(2,4,5)
hist(survivors(:,2), [1,2,3])
title("survivors ~ class")

subplot(2,4,6)
hist(survivors(:,3), [0,1])
title("survivors ~ gender")

subplot(2,4,7)
hist(survivors(:,4))
title("survivors ~ age")

subplot(2,4,8)
hist(survivors(:, 5))
title("survivors ~ ticket price")

hold on;