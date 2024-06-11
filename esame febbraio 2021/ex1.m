clc 
clear all

syms alfa beta gamma

r = [1/sqrt(3), -1/sqrt(3), 1/sqrt(3)]
theta = pi/6

% Matrice di rotazione intorno all'asse z
Rz = [cos(gamma), -sin(gamma), 0;
      sin(gamma),  cos(gamma), 0;
      0,            0,           1];
      
% Matrice di rotazione intorno all'asse y
Ry = [cos(beta), 0, sin(beta);
      0,            1, 0;
     -sin(beta), 0, cos(beta)];
      
% Matrice di rotazione intorno all'asse x
Rx = [1, 0,             0;
      0, cos(alfa), -sin(alfa);
      0, sin(alfa),  cos(alfa)];

R_tot = simplify(Rz * Ry * Rx, steps = 100)

% Dati del problema
r = [1/sqrt(3), -1/sqrt(3), 1/sqrt(3)];
theta = pi/6;

% Calcolo della matrice di rotazione
R = rotation_matrix(r, theta);

disp('Matrice di rotazione:');
disp(R);

r_11 = R(1,1);
r_21 = R(2,1);
r_31 = R(3,1);
r_32 = R(3,2);
r_33 = R(3,3);

beta_pos = atan2(-r_31, +sqrt((r_32)^2+(r_33)^2));
beta_neg = atan2(-r_31, -sqrt((r_32)^2+(r_33)^2));

alpha_pos = atan2(r_32/cos(beta_pos), r_33/(cos(beta_pos)));
alpha_neg = atan2(r_32/cos(beta_neg), r_33/(cos(beta_neg)));

gamma_pos = atan2(r_21/cos(beta_pos), r_11/(cos(beta_pos)));
gamma_neg = atan2(r_21/cos(beta_neg), r_11/(cos(beta_neg)));

disp("angles found")
disp("alpha_I: "+alpha_pos)
disp("beta_I: "+beta_pos)
disp("gamma_I: "+gamma_pos)
disp(" ")
disp("alpha_II: "+alpha_neg)
disp("beta_II: "+beta_neg)
disp("gamma_II: "+gamma_neg)

function R = rotation_matrix(r, theta)
    % Calcola la matrice di rotazione attorno ad un asse arbitrario
    % r     - vettore unitario (asse di rotazione)
    % theta - angolo di rotazione in radianti
    
    % Matrice identità
    I = eye(3);
    
    % Matrice antisimmetrica K costruita da r
    K = [  0,     -r(3),  r(2);
          r(3),   0,    -r(1);
         -r(2),  r(1),   0   ];
    
    % Matrice di rotazione
    R = I + sin(theta) * K + (1 - cos(theta)) * K^2;
end
