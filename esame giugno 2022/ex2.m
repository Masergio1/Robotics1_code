clc
clear all

syms q1 q2 q1_dot q2_dot

% Definisce le equazioni di posizione dell'end-effector
px = q2 * cos(q1);
py = q2 * sin(q1);

% Calcola la matrice Jacobiana
J = simplify(jacobian([px; py], [q1; q2]), steps = 100);

% Definisce le variabili simboliche per le velocità articolari
q_dot = [q1_dot;
         q2_dot];

% Calcola la derivata temporale della Jacobiana
dim = size(J);
J_dot = sym(zeros(dim(1), dim(2)));
q = [q1; q2]; % Definisce q come un array di simboli
for i = 1:dim(2)
    J_dot = J_dot + diff(J, q(i)) * q_dot(i);
end
J_dot = simplify(J_dot, steps = 10)

% Colleziona i termini trigonometrici per la semplicità
%J_dot = collect(J_dot, [cos(q1), sin(q1)]);

% Definisce il vettore posizione
p = [px;
     py];

% Calcola la derivata temporale della posizione
p_dot = simplify(jacobian(p, [q1, q2]) * q_dot, steps = 100)

% Calcola q_dot in funzione di p_dot
q_dot_inv = inv(J) * p_dot;

% Calcola q_dot_dot
q_dot_dot = simplify(-inv(J) * J_dot * q_dot, steps = 100)
