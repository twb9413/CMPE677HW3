clear ; close all;
% Given Data
% day of year
x =[4 62 120 180 242 297 365]';
% bank balance
y =[2720 1950 1000 1150 1140 750 250]';

scatter(x, y, 20, MarkerFaceColor='red', MarkerEdgeColor='blue')
grid on

% Create a NxK matrix
degree = 5;
X = ones(length(x), degree+1);

% populate the matrix
for i = 1:degree
    X(:, i+1) = x.^i;
end

% compute the coefficents
theta = (X'*X)\(X'*y);

% use those coefficients in plot
x_fit = linspace(1, 400, 100)';
y_fit = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3 + theta(5)*x_fit.^4 + theta(6)*x_fit.^5;

% calculate the avgSqErr
avgSqErr=sum((y-X*theta).^2)./length(y);

hold on
plot(x_fit, y_fit, '.b', LineWidth=3)
title(sprintf('%1.0fth order fit, \\lambda=0, avgSqErr=%.6f;',degree, avgSqErr))


