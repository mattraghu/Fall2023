% For a differential drive mobile robot as shown in the picture, program in Matlab to simulate the paths shown in Figure 3.20 of the Textbook, where the robot is initially on a circle in the xy plane. All movements should have smooth trajectories toward the goal in the center.

% Initial Position
r = 50
angle = -3*pi/4
x_0 = r*cos(angle)
y_0 = r*sin(angle)
theta_0 = 0
X0 = [x_0; y_0; theta_0]

% Solve ODE
tspan = [0, 10]
[t, X] = ode45(@f, tspan, X0)

% Plot
plot(X(:,1), X(:,2))

hold on
% Put a thing at the initial point
plot(x_0, y_0, 'g*')
hold on
% Put a thing at the last point
plot(X(end,1), X(end,2), 'b*')
hold off

% ODE Function for xdot
function xdot = f(t, X) % t is time, X is state vector
x = X(1)
y = X(2)
theta = X(3)

% Parameters
k_p = 3 % Proportional Gain for positional error
k_alpha = 8 % Proportional Gain for angular error
k_beta = -1.5 % Proportional Gain for angular error

% Goal
x_f = 0
y_f = 0
theta_f = 0

rho = sqrt((x_f - x)^2 + (y_f - y)^2) % Distance to goal

alpha = atan2(y_f - y, x_f - x) - theta % Angle to goal from current heading
beta = -alpha - theta % Angle to goal

% Control Law
v = k_p*rho
omega = k_alpha*alpha + k_beta*beta

% Define xdot
xdot = [v*cos(theta); v*sin(theta); omega]
end




