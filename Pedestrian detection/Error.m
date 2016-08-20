function [ accPer,  p] = Error( X_test, y_test,Theta1,Theta2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p=predict(Theta1,Theta2,X_test);

diff=sum(xor(p, y_test));
[s,~] = size(y_test);
accPer = ((s - diff)/s)*100;
end

