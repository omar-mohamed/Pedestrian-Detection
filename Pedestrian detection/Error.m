function [ accPer,  p] = Error( X, y_test)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p=predict(Theta1,Theta2,X);

diff=sum(xor(p, y_test));
[s,~] = size(y_test);
accPer = ((s - diff)/s)*100;
end

