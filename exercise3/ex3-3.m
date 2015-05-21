warning ("off", "Octave:broadcast");

clusterData = load("../data/clusters.txt");

k = 3;

clusterCenters = unifrnd(0.0, 100.0, k, 2);

for i = 1:6
	distances = cell2mat(arrayfun(@(n) norm(clusterData - clusterCenters(n,:), 2, "rows"), 1:k, "UniformOutput", false));
	clusterIndices = nthargout(2, @min, distances')';

	p = subplot(2,3,i);
	scatter(clusterData(:,1), clusterData(:,2), [], clusterIndices);
	hold on;
	voronoi(clusterCenters(:,1), clusterCenters(:,2));
	xlim(p, [0.0, 100.0]);
	ylim(p, [0.0, 100.0]);
	hold off;

	clusterCenters = cell2mat(arrayfun(@(n) mean(clusterData(clusterIndices==n,:))', 1:k, "UniformOutput", false))';
end