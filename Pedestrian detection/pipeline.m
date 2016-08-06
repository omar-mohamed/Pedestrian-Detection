%% Setup the parameters you will use 
input_layer_size  = 400;  % 20x20 
hidden_layer_size = 25;   % 25 hidden units
num_labels = 1;          % 0 or 1

%% ===========  Loading Data =============

fprintf('Loading  Data ...\n')

load('ex4data1.mat','X');

load('ex4data1.mat','y');

load('ex4data1.mat','mu');

load('ex4data1.mat','sigma');

%% ================ Initializing Pameters ================

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% ===================  Training NN ===================


fprintf('\nTraining Neural Network... \n')


options = optimset('MaxIter', 1000);

lambda = 1;

costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));


