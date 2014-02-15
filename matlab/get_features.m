function V = get_features(data, labels, numToSelect, method)
selectedFeatures = feast(method, numToSelect,data,labels);
V = zeros(1, size(data,2))';
V(selectedFeatures) = 1;