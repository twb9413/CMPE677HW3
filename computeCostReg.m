function J = computeCostReg(Xdata, Y, theta, lambda)
    n = length(Y); % number of training examples
    h = Xdata * theta;
    J = (1/(2*n)) * (sum((h - Y) .^ 2) + (lambda * sum(theta(2:end).^2))); % cost function
end

