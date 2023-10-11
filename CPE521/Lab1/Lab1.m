% Define a list of angles for different initial positions on the circle
angles_list = 1:pi/4:2*pi;
% Initialize a figure for plotting
figure;

% Loop through each initial angle
for angle = angles_list
    disp(angle)
    % Initial Position
    r = 50;
    x_0 = r*cos(angle);
    y_0 = r*sin(angle);
    theta_0 = 0;
    X0 = [x_0; y_0; theta_0];
    
    % Solve ODE
    tspan = [0, 10];
    [t, X] = ode45(@f, tspan, X0);
    disp("here")
    % Plot
    hold on;
    plot(X(:,1), X(:,2));
    
    % Mark the initial point
    plot(x_0, y_0, 'g*');
    
    % Mark the last point
    plot(X(end,1), X(end,2), 'b*');
end

% Turn off hold
hold off;

% ODE Function for xdot
function xdot = f(t, X) % t is time, X is state vector
x = X(1);
y = X(2);
theta = X(3);

% Parameters
k_p = 3; % Proportional Gain for positional error
k_alpha = 8; % Proportional Gain for angular error
k_beta = -1.5; % Proportional Gain for angular error

% Goal
x_f = 0;
y_f = 0;
theta_f = 0;

rho = sqrt((x_f - x)^2 + (y_f - y)^2); % Distance to goal
alpha = atan2(y_f - y, x_f - x) - theta; % Angle to goal from current heading
beta = -alpha - theta; % Angle to goal

% Control Law
v = k_p*rho;
omega = k_alpha*alpha + k_beta*beta;

% Define xdot
xdot = [v*cos(theta); v*sin(theta); omega];
end
