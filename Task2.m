%%Clusing clustering to produce smaller sets of templates for each class
tic
Nclasses = 10;
M = 64;
ClusteredSet = zeros(M*Nclasses,n);
clusterLabels = repelem([0 1 2 3 4 5 6 7 8 9]', M);

%%need to sort the training data
[sorted_trainlab, sort_index] = sort(trainlab);
sorted_trainv = zeros(num_train, n);

for m = 1:num_train
    sorted_trainv(m,:) = trainv(sort_index(m),:);
end


i = 1;
j = 1;
%%go through and cluster the sorted set, one class at a time
for x = 0: (Nclasses-1)
    j = i;
    while i < num_train && sorted_trainlab(i+1) == x
        i = 1+i;
    end
    
    %cluster one class at a time
    trainvi = sorted_trainv(j:i,:); 
    [idxi, Ci] = kmeans(trainvi, M);
    ClusteredSet((x*M+1):((x+1)*M),:) = Ci;
    fprintf('Class %d clustered\n',x);
end

FinalLables = NN(ClusteredSet,clusterLabels,testv,Nclasses,M);

toc
