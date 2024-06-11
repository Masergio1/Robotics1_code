clc
clear all

L1=0.4;
L2=sqrt(0.4^2 + 0.3^2);

% Angles of the first joint (q1) and the second joint (q2), set here
% physical limitations
q1 = linspace(2*pi, 0, 100);
q2 = linspace(0, 2*pi, 100);

% Initialize arrays for storing workspace points
workspace_x = [];
workspace_y = [];

% Loop through all possible combinations of q1 and q2
for i = 1:length(q1)
    for j = 1:length(q2)
        % Calculate the end effector position using the forward kinematics
            x_val=L1*cos(q1(i))+L2*cos(q1(i)+q2(j));
            y_val=L1*sin(q1(i))+L2*sin(q1(i)+q2(j));
            % Store the workspace points
            workspace_x = [workspace_x, x_val];
            workspace_y = [workspace_y, y_val];
    end
end

% Define the point coordinates
point_x = 0;
point_y = 0;

% Create the plot for the workspace and the point
% figure;
% plot(workspace_x, workspace_y, '.', 'DisplayName', 'Workspace of the End Effector');
% hold on;
% plot(point_x, point_y, 'rx', 'DisplayName', 'Point'); % Red point
% hold off;
% xlim([-3, 3]);
% ylim([-3, 3]);
% axis equal;
% title('Workspace and Point');
% xlabel('x Axis');
% ylabel('y Axis');
% legend;
% grid on;

%second part
phi = -(53*pi)/180 ;  % Rotazione attorno all'asse Z
theta = pi/2;  % Rotazione attorno all'asse Y

% Matrici di rotazione 
Rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1];
Ry = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];

% Applicazione delle rotazioni
R = Rz * Ry



