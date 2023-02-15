function [theta, J_history] = gradientDescentMultiReg(Xdata, y, theta, alpha, num_iters, lambda)
% Initialize some useful values
n = length(y); % number of training examples
m = size(theta, 1); % get the size needed for the theta_temp
J_history = zeros(num_iters, 1);

    for iter = 1:num_iters
        
        % Create a temporary theta vector to store the updated values
        theta_temp = zeros(m, 1);
        
        % iterate through all parts
        for j = 1:m
            theta_temp(j) = theta(j) - (alpha/n)*(sum((Xdata*theta-y).*Xdata(:,j)) + lambda * theta(j));
        end
        
        theta = theta_temp;
        
        % Save the cost J in every iteration    
        J_history(iter) = computeCostReg(Xdata, y, theta, lambda);
    end
end
