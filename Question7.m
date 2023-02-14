clear ; close all;
%percent of way in semester
x =[0  0.2072  0.3494 0.4965  0.6485  0.7833  0.9400]';
%bank balance ($K)
y =[2.150 1.541  0.790 0.909  0.901  0.593 0.198]' ;


scatter(x, y, 10, MarkerFaceColor='red', MarkerEdgeColor='blue')
grid on

D = [1, 3, 5];
L = [0, 0.001, 1];
pos = 1;

for i = 1:length(D)
    % set the degree for this run
    degree = D(i);
    for j = 1:length(L)
        % set the lambda for this run
        lambda = L(j);

        subplot(3,3,pos)
        scatter(x, y, 10, MarkerFaceColor='red', MarkerEdgeColor='blue')
        grid on
        % with d and lambda set, calculate the stuff
        X = ones(length(x), degree+1);
        % populate the matrix
        for k = 1:degree
            X(:, k+1) = x.^k;
        end
        
        % compute the coefficents with regularizer
        I = eye(degree+1);
        I(1,1) = 0; % set the top left element to zero to exclude regularization of the constant term
        theta = (X'*X + lambda*I)\(X'*y);
        
        % use those coefficients in plot
        x_fit = linspace(0, 1, 100)';

        % plot the appropriate graph for the degree
        if degree == D(1)
            y_fit = theta(1) + theta(2)*x_fit;
        elseif degree == D(2)
            y_fit = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3;
        elseif degree == D(3)
            y_fit = theta(1) + theta(2)*x_fit + theta(3)*x_fit.^2 + theta(4)*x_fit.^3 + theta(5)*x_fit.^4 + theta(6)*x_fit.^5;
        end
        
        % calculate the avgSqErr
        avgSqErr=sum((y-X*theta).^2)./length(y);

        hold on
        plot(x_fit, y_fit, '.m', LineWidth=3)
        title(sprintf('D=%1.0f, \\lambda=%1.3f',degree, lambda), FontSize=8, FontWeight="normal")

        % increment position for next subplot
        pos = pos + 1;

    end
end

print -dpng HW3Q7.png
