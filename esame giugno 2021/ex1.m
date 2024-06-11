clear all
clc

% Definire la matrice di rotazione attorno all'asse y di -pi/2
theta_y = pi/2;
R_y = [cos(theta_y), 0, sin(theta_y); 
       0, 1, 0; 
       -sin(theta_y), 0, cos(theta_y)];

% Definire la matrice di rotazione attorno all'asse z di pi/2
theta_z = pi/2;
R_z = [cos(theta_z), -sin(theta_z), 0; 
       sin(theta_z), cos(theta_z), 0; 
       0, 0, 1];

% Calcolare il prodotto delle due matrici di rotazione
R = R_y * R_z;

% Visualizzare le matrici e il risultato
disp('Matrice di rotazione attorno all''asse y di -pi/2:');
disp(R_y);

disp('Matrice di rotazione attorno all''asse z di pi/2:');
disp(R_z);

disp('Prodotto delle due matrici di rotazione:');
disp(R);