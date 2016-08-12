function [ Theta1, Theta2 ] = trainNeuralNetwork( hidden_layer_size,lambda, trainingStepsMax, nRepetitions)


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

load('X_test_norm.mat');

load('y_test.mat');

%load('Meu.mat','mu');

%load('Sigma.mat','sigma');

%% ================ Initializing Pameters ================

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% ===================  Training NN ===================


fprintf('\nTraining Neural Network... \n')


options = optimset('MaxIter', trainingStepsMax);

%lambda = 1;

costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X_norm, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
minCost = 1000000;
for i=1 : nRepetitions
    [nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
    
    if (cost < minCost)
        bestParams = nn_params;
        minCost = cost;
    end
end
% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(bestParams(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(bestParams((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));



end

