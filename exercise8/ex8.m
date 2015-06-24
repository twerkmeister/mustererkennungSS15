
#a

function f = functionNumber(w)
  bias = 1;
  tupels = [0,0,bias; 0,1,bias; 1,0,bias; 1,1,bias]';
  f = (w*tupels >= 0) * [1,2,4,8]';
end

v1 = functionNumber([0.3, 0.5, -0.4])
v2 = functionNumber([-0.8, -0.6, 0.5])
v3 = functionNumber([0.7, 0.6, -1.0])

#b

function sample = sphereSample()
  do
    sample = unifrnd(-1, 1, 1, 3);
    length = norm(sample);
    sample = sample / length;
  until length <= 1
end

samples = arrayfun(@sphereSample, [1:10000], "UniformOutput", false);
sampleMat = cell2mat(samples');
subplot(2,2,1);
scatter3(sampleMat(:,1), sampleMat(:,2), sampleMat(:,3));

#c

functions = cellfun(@functionNumber, samples);
histdata = arrayfun(@(n) sum(functions == n), [0:15]) / length(samples);
subplot(2,2,3);
bar([0:15], histdata);
ratio = max(histdata) / min(histdata(histdata > 0))

#d

function f = functionNumberNegative(w)
  bias = 1;
  tupels = [-1,-1,bias; -1,1,bias; 1,-1,bias; 1,1,bias]';
  f = (w*tupels >= 0) * [1,2,4,8]';
end

functions = cellfun(@functionNumberNegative, samples);
histdata = arrayfun(@(n) sum(functions == n), [0:15]) / length(samples);
subplot(2,2,4);
bar([0:15], histdata);
ratio = max(histdata) / min(histdata(histdata > 0))
