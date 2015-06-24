
#a

function f = functionNumber(w)
  bias = 1;
  tupels = [0,0,bias; 0,1,bias; 1,0,bias; 1,1,bias]';
  f = (w*tupels >= 0) * [1,2,4,8]';
end

functionNumber([0.3, 0.4, 0.5])
functionNumber([-0.2, 0.8, 0.3])
functionNumber([1.0, 1.0, 0.0])

#b

function sample = sphereSample()
  do
    sample = unifrnd(-1, 1, 1, 3);
    length = norm(sample);
    sample = sample / length;
  until length <= 1
end

samples = arrayfun(@sphereSample, [1:100], "UniformOutput", false);
sampleMat = cell2mat(samples);
#scatter3(sampleMat(:,1), sampleMat(:,2), sampleMat(:,3));

#c

functions = cellfun(@functionNumber, samples);
histdata = arrayfun(@(n) sum(functions == n), [0:15]) / length(samples);
ratio = max(histdata) / min(histdata(histdata > 0))
bar(histdata);

#d

