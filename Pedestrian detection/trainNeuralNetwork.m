function [ Theta1, Theta2 ] = trainNeuralNetwork( hiddenLayerSize,lambda, trainingStepsMax, nRepetitions)


if nargin < 4
    nRepetitions = 1;
end

%% Setup the parameters you will use 
input_layer_size  = 8192;   
num_labels = 1;          % 0 or 1

%% ===========  Loading Data =============

fprintf('Loading  Data ...\n')

load('X_norm.mat');

load('y.mat');

%load('X_test_norm.mat');

%load('y_test.mat');

%load('Meu.mat','mu');

%load('Sigma.mat','sigma');

%% ================ Initializing Pameters ================

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hiddenLayerSize);
initial_Theta2 = randInitializeWeights(hiddenLayerSize, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% ===================  Training NN ===================


fprintf('\nTraining Neural Network... \n')


options = optimset('MaxIter', trainingStepsMax);

%lambda = 1;

costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hiddenLayerSize, ...
                                   num_labels, X_norm, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
minCost = 1000000;
n = 0;
for i=1 : nRepetitions
    fprintf('\n Calculating the %d Repitition...\n', i);
    [nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
    lastCost=cost(size(cost,1));
    fprintf('Cost in this Repitition: %d\n',lastCost );
    if (lastCost < minCost)
        n = i; 
        bestParams = nn_params;
        minCost = lastCost;
    end
end
fprintf('\n Chosen the %d Repitition with minCost = %d \n', n, minCost);
% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(bestParams(1:hiddenLayerSize * (input_layer_size + 1)), ...
                 hiddenLayerSize, (input_layer_size + 1));

Theta2 = reshape(bestParams((1 + (hiddenLayerSize * (input_layer_size + 1))):end), ...
                 num_labels, (hiddenLayerSize + 1));



end

