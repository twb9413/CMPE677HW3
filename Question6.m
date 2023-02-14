clear ; close all;

%percent of way in semester
x =[0  0.2072  0.3494 0.4965  0.6485  0.7833  0.9400]';
%bank balance ($K)
y =[2.150 1.541  0.790 0.909  0.901  0.593 0.198]' ;

% implement regularized linear regression with lambda=.001
scatter(x, y, 10, MarkerFaceColor='red', MarkerEdgeColor='blue')
grid on

% Create a NxK matrix
degree = 5;
X = ones(length(x), degree+1);

% populate the matrix
for i = 1:degree
    X(:, i+1) = x.^i;
end

% compute the coefficents with regularizer
lambda = 0.001;
I = eye(degree+1);
I(1,1) = 0; % set the top left element to zero to exclude regularization of the constant term
theta = (X'*X + lambda*I)\(X'*y);

% use those coefficients in plot
x_fit = linspace(0, 1, 100)';
y_fit = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3 + theta(5)*x_fit.^4 + theta(6)*x_fit.^5;


% calculate the avgSqErr
avgSqErr=sum((y-X*theta).^2)./length(y);


hold on
plot(x_fit, y_fit, '.m', LineWidth=3)
xlabel("Percent Through Semester", FontSize=12)
ylabel("Bank Account Balance ($K)", FontSize=12)
title(sprintf('%1.0fth order fit, \\lambda=%1.3f, avgSqErr=%.6f',degree, lambda, avgSqErr), FontSize=14, FontWeight="normal")

print -dpng HW3Q6.png
