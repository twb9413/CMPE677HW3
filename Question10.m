clear ; close all;
data = load('ex1data1.txt'); % Dataset from Andrew Ng, Machine Learning MOOC
X = data(:, 1); 
y = data(:, 2);
M = [ones(length(X),1) X];
theta_init = zeros(2, 1); % initialize fitting parameters to zero
 
% Some gradient descent settings
iterations = 1500;
alpha = 0.01;
lambda = 100;
 
% run gradient descent
theta_unreg = gradientDescentMultiReg(M, y, theta_init, alpha, iterations,lambda);
lin_reg = ((M'*M)\M')*y;  % optimal solution
lambda = 100;
theta_reg = gradientDescentMultiReg(M, y, theta_init, alpha, iterations,lambda);
 
fprintf('Linear Regression: [%f,%f]\n',lin_reg);
fprintf('Gradient Descent: [%f,%f]\n',theta_unreg);
fprintf('Regularized Gradient Descent: [%f,%f]\n',theta_reg);
