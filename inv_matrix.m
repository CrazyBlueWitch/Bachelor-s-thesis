clc; clear all; close all;

% syms a11 a12 a13 a14 a15 a16 a21 a22 a23 a24 a25 a26 a31 a32 a33 a34 a35 a36 a41 a42 a43 a44 a45 a46 a51 a52 a53 a54 a55 a56 a61 a62 a63 a64 a65 a66
% A = [a11 a12 a13 a14 a15 a16; a21 a22 a23 a24 a25 a26; a31 a32 a33 a34 a35 a36; a41 a42 a43 a44 a45 a46; a51 a52 a53 a54 a55 a56; a61 a62 a63 a64 a65 a66]
% A_inv = inv(A);
% det_A = det(A);
% G1 = eye(6,6);
% a1 = -(1/1)*trace(G1*A);
% G2 = a1*eye(6,6)+G1*A;
% a2 = -(1/2)*trace(G2*A);
% G3 = a2*eye(6,6)+G2*A;
% a3 = -(1/3)*trace(G3*A);
% G4 = a3*eye(6,6)+G3*A;
% a4 = -(1/4)*trace(G4*A);
% G5 = a4*eye(6,6)+G4*A;
% a5 = -(1/5)*trace(G5*A);
% G6 = a5*eye(6,6)+G5*A;
% a6 = -(1/6)*trace(G6*A);
A = [0 1 0; 0 0 1; 0 -1 -.3];
I_A = eye(3,3)-A;
inv(I_A)
inv([1 -1 0; 0 1 -1; 0 1 1.3])
G1 = eye(3,3);
a1 = -(1/1)*trace(G1*[1 -1 0; 0 1 -1; 0 1 1.3]);
G2 = a1*eye(3,3)+G1*[1 -1 0; 0 1 -1; 0 1 1.3];
a2 = -(1/2)*trace(G2*[1 -1 0; 0 1 -1; 0 1 1.3]);
G3 = a2*eye(3,3)+G2*[1 -1 0; 0 1 -1; 0 1 1.3];
a3 = -(1/3)*trace(G3*[1 -1 0; 0 1 -1; 0 1 1.3]);
(G1+G2+G3)/(det([1 -1 0; 0 1 -1; 0 1 1.3]))
