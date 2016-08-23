function [ accPer, bestTheta1, bestTheta2, p ] = provingGrounds(startingHiddenLayerSize, maxHiddenLayerSize,startingLambda, maxLambda,trainingStepsMax,nRepetitions )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

load('X_test_norm.mat');
load('y_test.mat');

bestAccuracy=0;

for hiddenLayerSize=startingHiddenLayerSize:maxHiddenLayerSize
    fprintf('Calculating with size of hidden layer = %d...\n', hiddenLayerSize);
     lambda = startingLambda;
    while lambda<=maxLambda
        fprintf('At Lambda = %.2d \n', lambda);
         [ Theta1, Theta2 ] = trainNeuralNetwork( hiddenLayerSize,lambda, trainingStepsMax, nRepetitions);
         [ accPer,  p] = Error( X_test_norm, y_test,Theta1,Theta2);
         fprintf('Accuracy = %3.2d\n', accPer)
         if(accPer>bestAccuracy)
             bestAccuracy=accPer;
             bestTheta1 = Theta1;
             bestTheta2 = Theta2;
         end
         lambda=lambda*2;
    end
end

