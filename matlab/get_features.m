function V = get_features(data, labels, n_select, method)
selected_features = feast(method, n_select, data, labels);
V = zeros(1, size(data,2))';
V(selected_features) = 1;
