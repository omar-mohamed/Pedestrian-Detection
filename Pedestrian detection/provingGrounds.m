function [ accPer, bestTheta1, bestTheta2, p ] = provingGrounds( max_hidden_layer_size, max_lambda,trainingStepsMax,nRepetitions )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
best_accuracy=0; lambda = 0.01;

for hidden_layer_size=1:max_hidden_layer_size
    for lambda=0.01:lambda:max_lambda
         [ Theta1, Theta2 ] = trainNeuralNetwork( hidden_layer_size,lambda, trainingStepsMax, nRepetitions);
         [ accPer,  p] = Error( X, y_test);
         if(accPer>best_accuracy)
             best_accuracy=accPer;
             bestTheta1 = Theta1;
             bestTheta2 = Theta2;
         end
    end
end

