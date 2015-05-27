warning ("off", "Octave:broadcast");

clusterData = load("../data/clusters.txt");
nRows = rows(clusterData);

randomIndex= randperm(nRows);

k = 3;

clusterCenters = clusterData(randomIndex(1:k),:);

for i = 1:6
	distances = cell2mat(arrayfun(@(n) norm(clusterData - clusterCenters(n,:), 2, "rows"), 1:k, "UniformOutput", false));
	clusterIndices = nthargout(2, @min, distances')';

	p = subplot(2,3,i);
	scatter(clusterData(:,1), clusterData(:,2), [], clusterIndices);
	hold on;
	voronoi(clusterCenters(:,1), clusterCenters(:,2));
	xlim(p, [0.0, 100.0]);
	ylim(p, [0.0, 100.0]);
	title(sprintf("iteration %d",i));
	hold off;

	clusterCenters = cell2mat(arrayfun(@(n) mean(clusterData(clusterIndices==n,:))', 1:k, "UniformOutput", false))';
end