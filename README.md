# Neyman-Pearson Based Feature Selection (NPFS) post-hoc test

TBD

# Installation
The scripts can be copied into the default Matlab path (usually something like `~/Matlab/`), or add the path of where you placed the scripts into Matlab's working path (e.g., `addpath('/path/to/NPFS/scripts/')`).

# Example

This tutorial assumes that the [FEAST](http://www.cs.man.ac.uk/~gbrown/fstoolbox/) feature selection toolbox for Matlab has been compiled and installed to the Matlab path. The current implementation of NPFS uses FEAST; however, you are not limited to using FEAST's feature selection implementations. The `get_features.m` script can be modified to include different base variable selection algorithms. Just replace the `feast` function call with anothor function that returns `n_select` of `n_features` indices that are relevant.  

## Generating the Data

First, let us begin by generating some data, and just as importantly generating some data that we can easily interpret when it comes time to apply feature selection. We are going to generate some `n_features` that are integers in the range 0 to 10, and the labels are going to be chosen such that if the sum of the 1st `n_relevant` features is ggreat than some threshold, then the example is labeled 1 and otherwise recieves the label 2. The code to do this is shown below.  

```
  n_features = 50;
  n_observations = 1000; 
  n_relevant = 10;

  % feast wants 
  data = round(10*rand(n_observations, n_features));
  label_sum = sum(data(:, 1:n_relevant), 2);
  delta = mean(label_sum);
  labels = zeros(n_observations, 1);
  labels(label_sum > delta) = 1;
  labels(label_sum <= delta) = 2;
```


## Running NPFS

The `npfs.m` function assumes that FEAST has already been compiled and added to the Matlab path. Once this is done, `NPFS` can be called as follows.   

```
  n_select = 5;
  n_boots = 100;
  beta = 0;  % haven't published on this term
  alpha = 0.01;
  method = 'mim';
  idx = npfs(data, labels, method, n_select, n_boots, alpha, beta);
```

However, running the above code could take a long time to run depending on how many bootstraps you choose to use. As discussed in the manuscript `NPFS` can easily be parallelized. Parallelism is also implemented in `npfs.m`. To take advantage of this, run:

```
  matlabpool open local 12
  idx = npfs(data, labels, method, n_select, n_boots, alpha, beta);
  matlabpool close force
```

Note that you're limited to the number of parallel workers that you can open. Hence the above code may not work on laptops. 



## Interpreting the results 

# Citing NPFS
* Gregory Ditzler, Robi Polikar, Gail Rosen, "A Bootstrap Based Neyman–Pearson Test for Identifying Variable Importance," *IEEE Transactions on Neural Networks and Learning Systems*, 2014, under revision. ([pdf](http://gditzler.github.io/publications/tnnls2014.pdf))


