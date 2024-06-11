clc 
clear all

% Angoli di Eulero (in radianti)
phi = pi/3;  % Rotazione attorno all'asse Z
theta = pi/3;  % Rotazione attorno all'asse Y
psi = -pi/2;  % Rotazione attorno all'asse X

R_i = [sqrt(2)/2 0  sqrt(2)/2;
       0        -1  0;
       sqrt(2)/2 0  -sqrt(2)/2];

% Matrici di rotazione 
Rz = [cos(phi) -sin(phi) 0; sin(phi) cos(phi) 0; 0 0 1];
Ry = [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];
Rx = [1 0 0; 0 cos(psi) -sin(psi); 0 sin(psi) cos(psi)];

% Applicazione delle rotazioni
R = Rx * Ry * Rz

%second part 
[r_1, theta_1] = axis_angle_representation(R)

%third part
r_0_1 = R_i * r_1

function [r, theta] = axis_angle_representation(R)
    % Calcola l'angolo di rotazione
    theta = acos((trace(R) - 1) / 2);

    % Calcola il vettore asse di rotazione
    r = (1 / (2 * sin(theta))) * [
        R(3,2) - R(2,3);
        R(1,3) - R(3,1);
        R(2,1) - R(1,2);
    ];
end




