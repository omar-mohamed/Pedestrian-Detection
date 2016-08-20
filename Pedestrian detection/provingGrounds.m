function [ accPer, bestTheta1, bestTheta2, p ] = provingGrounds( maxHiddenLayerSize, maxLambda,trainingStepsMax,nRepetitions )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bestAccuracy=0; lambda = 0.01;

for hiddenLayerSize=1:maxHiddenLayerSize
    fprintf('Calculating Layer %d...\n', hiddenLayerSize);
    for lambda=0.01:lambda:maxLambda
        fprintf('At Lambda = %d \n', lambda);
         [ Theta1, Theta2 ] = trainNeuralNetwork( hiddenLayerSize,lambda, trainingStepsMax, nRepetitions);
         [ accPer,  p] = Error( X, y_test);
         fprintf('Error = %d\n', accPer)
         if(accPer>bestAccuracy)
             bestAccuracy=accPer;
             bestTheta1 = Theta1;
             bestTheta2 = Theta2;
         end
    end
end

