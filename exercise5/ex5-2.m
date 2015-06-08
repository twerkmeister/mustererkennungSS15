data = load("../data/fisher.txt");

group1 = data(data(:,3)==0,1:2);
group2 = data(data(:,3)==1,1:2);

m1 = mean(group1);
m2 = mean(group2);

S1 = cov(group1) * (length(group1)-1);
S2 = cov(group2) * (length(group2)-1);

SW = S1+S2;

wOrig = inv(SW)*(m1-m2)';
w = wOrig / norm(wOrig);


scatter(group1(:,1), group1(:,2));
hold on;
scatter(group2(:,1), group2(:,2),"r", "o");

projectedGroup1 = group1 * w;
projectedGroup2 = group2 * w;

projectedGroup1to2D = projectedGroup1*w';
projectedGroup2to2D = projectedGroup2*w';

scatter(projectedGroup1to2D(:,1), projectedGroup1to2D(:,2),"b", "x");
scatter(projectedGroup2to2D(:,1), projectedGroup2to2D(:,2),"r", "x");

wx = [-1000*w,1000*w](:,1);
wy = [-1000*w,1000*w](:,2);
line(wx,wy);

axis("equal");

projectedM1 = mean(projectedGroup1);
projectedM2 = mean(projectedGroup2);

projectedStd1 = std(projectedGroup1);
projectedStd2 = std(projectedGroup2);

w0 = gaussIntersect(projectedM1, projectedM2, projectedStd1, projectedStd2) * w';

plot(w0(:,1), w0(:,2), "kp", "markersize", 15, "markerfacecolor", "k");