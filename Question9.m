clear ; close all; 
% Load Data
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
 
% Scale features and set them to zero mean with std=1
[Xnorm mu sigma] = featureNormalize(X);  % reuse this function from hwk2
 
% Add intercept term to X
Xdata = [ones(length(X),1) Xnorm];
 
% Init Theta and lambda
theta = ((Xdata'*Xdata)\Xdata')*y;  %well..this is the optimal solution
lambda=1;
 
%Run Compute Cost 
disp(computeCostReg(Xdata,y,theta, lambda))

