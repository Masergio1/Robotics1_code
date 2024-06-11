clc 
clear all

syms alfa beta gamma

%prima parte
R_y = [cos(alfa)  0  sin(alfa);
       0           1  0;
       -sin(alfa)  0  cos(alfa)];

R_x = [1  0            0;
       0  cos(beta)  -sin(beta);
       0  sin(beta)   cos(beta)];

R_z = [cos(gamma)  -sin(gamma)  0;
       sin(gamma)   cos(gamma)  0;
       0            0           1];

R_tot = simplify(R_z * R_x * R_y, steps = 100)

det_R = simplify(det(R_tot), steps = 100)

%terza parte
% Define Euler angle solutions
phi_d1 = [pi/2, 0, pi/2];
phi_d2 = [-pi/2, pi, pi/2];

% Define transformation matrices corresponding to each solution
Td1 = euler_to_matrix(phi_d1);
Td2 = euler_to_matrix(phi_d2);

% Display the transformation matrices
disp("Transformation Matrix T_d1:");
disp(Td1);

disp("Transformation Matrix T_d2:");
disp(Td2);

function T = euler_to_matrix(phi)
    alpha = phi(1);
    beta = phi(2);
    gamma = phi(3);
    
    % Calculate elements of the transformation matrix
    c1 = cos(alpha);    s1 = sin(alpha);
    c2 = cos(beta);     s2 = sin(beta);
    c3 = cos(gamma);    s3 = sin(gamma);
    
    % Construct the transformation matrix
    T = [c1*c2, c1*s2*s3 - c3*s1, s1*s3 + c1*c3*s2;
         c2*s1, c1*c3 + s1*s2*s3, c3*s1*s2 - c1*s3;
         -s2, -c2*s3, c2*c3];
end
