clear; close all
rng(2000);  %random number generator seed
mu = [0 0 ];
sigma = [4 1.5 ; 1.5 2];
r = mvnrnd(mu,sigma,50); %create two features, 50 samples of each
y = r(:,1);
x=(pi*(1:50)/20)';  %scale x for sin
y=10*sin(x).*(4+y); % add some curvature
y =y + x*4;  % gradually rise over time
hold off; plot(x,y,'x'); 
 
xtrain = x(1:2:end); ytrain = y(1:2:end);  %odd samples for train
xtest = x(2:2:end); ytest = y(2:2:end);    %even samles for test
figure(1);
hold off
plot(xtrain, ytrain, 'rs', 'MarkerSize', 10,'LineWidth',3,'markerfacecolor','c','markeredgecolor','b'); % Plot the data
hold on
plot(xtest, ytest, 'ro', 'MarkerSize', 10,'LineWidth',3,'markerfacecolor','m','markeredgecolor','r'); % Plot the data
grid on; legend('train','test');
print -dpng hwk3_problem8_data.png

% my code
% Create M matrix (xData)
M = [ones(size(x)) x x.^2 x.^3];

degree = 3;
% compute the coefficents with regularizer
min_lambda = .0012;
I = eye(degree+1);
I(1,1) = 0; % set the top left element to zero to exclude regularization of the constant term
theta = (M'*M + min_lambda*I)\(M'*y);

x_fit = linspace(0, 8, 100)';
y_fit1 = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3;

hold on
plot(x_fit, y_fit1, 'm', LineWidth=3)

lambdaSE1 = 0.0588;
theta = (M'*M + lambdaSE1*I)\(M'*y);

y_fit2 = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3;
plot(x_fit, y_fit2, '.b', LineWidth=3)
grid on; legend('train','test', 'lambda-min', 'lambda-SE1');
print -dpng HW3Q8d.png

% Perform Lasso regression with 2-fold cross-validation
[B, FitInfo] = lasso(M, y, 'CV', 2);

% Plot cross-validation results
lassoPlot(B, FitInfo, 'PlotType', 'CV');


M = [ones(size(xtrain)) xtrain xtrain.^2 xtrain.^3];

degree = 3;
% compute the coefficents with regularizer
min_lambda = .0012;
I = eye(degree+1);
I(1,1) = 0; % set the top left element to zero to exclude regularization of the constant term
theta = (M'*M + min_lambda*I)\(M'*ytrain);

x_fit = linspace(0, 8, 100)';
y_fit1 = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3;

% calculate the avgSqErr
avgSqErr=sum((ytrain-M*theta).^2)./length(ytrain);
disp("training data avgSqErr: "+ avgSqErr)
avgSqErr=sum((ytest-M*theta).^2)./length(ytest);
disp("test data avgSqErr: "+ avgSqErr)
