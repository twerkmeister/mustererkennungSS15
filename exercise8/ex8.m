
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
    sample = unifrnd(-1, 1, 3, 1);
    length = norm(sample);
    sample = sample / length;
  until length <= 1
end

samples = cell2mat(arrayfun(@sphereSample, [1:10000], "UniformOutput", false))';
scatter3(samples(:,1), samples(:,2), samples(:,3));

#c

functions = arrayfun(@functionNumber, samples);