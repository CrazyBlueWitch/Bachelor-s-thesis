clc; clear all; close all

d1 = 0.2755;
d2 = 0.41;
d3 = 0.2073;
d4 = 0.1038;
d5 = 0.1038;
d6 = 0.16;
e2 = 0.0098;

% t1 = 283.121582031-180;
% t2 = 162.885742188+90;
% t3 = 43.4833030701+90;
% t4 = 265.342041016;
% t5 = 257.606964111;
% t6 = 288.019165039-90;
syms t1 t2 t3 t4 t5 t6 
% Въвеждаме хомогенни преубразования между кординатните сми на манипулатора
Tb0 = [1   0   0   0; 
       0  -1   0   0; 
       0   0  -1   0; 
       0   0   0   1];

T01 = [cos(t1)     0           sin(t1)    0;
       sin(t1)     0          -cos(t1)    0; 
       0           1           0         -d1; 
       0           0           0          1];

T12 = [cos(t2)     sin(t2)     0          d2*cos(t2);
       sin(t2)    -cos(t2)     0          d2*sin(t2);
       0           0          -1          0;
       0           0           0          1];

T23 = [cos(t3)     0           sin(t3)    0;
       sin(t3)     0          -cos(t3)    0;
       0           1           0         -e2;
       0           0           0          1];

T34 = [cos(t4)     0           sin(t4)    0;
       sin(t4)     0          -cos(t4)    0;
       0           1           0        -(d3+d4);
       0           0           0          1];

T45 = [cos(t5)     0           sin(t5)    0;
       sin(t5)     0          -cos(t5)    0;
       0           1           0          0;
       0           0           0          1];

T56 = [cos(t6)     sin(t6)     0          0;
       sin(t6)    -cos(t6)     0          0;
       0           0          -1         -(d5+d6);
       0           0           0          1];

% Изразяване на ориентация и позиция на коорд с-ми спрямо базова
Tb1 = Tb0*T01;
Tb2 = Tb1*T12;
Tb3 = Tb2*T23;
Tb4 = Tb3*T34;
Tb5 = Tb4*T45;
Tb6 = Tb5*T56

% Визуализация на получените резултати
% figure(1)
% plot3(Tb0(1,4), Tb0(2,4), Tb0(3,4), 'b*')
% line([0 Tb0(1,4)],[0 Tb0(2,4)],[0 Tb0(3,4)])
% hold on
% 
% plot3(Tb1(1,4), Tb1(2,4), Tb1(3,4), 'b*')
% line([Tb0(1,4) Tb1(1,4)],[Tb0(2,4) Tb1(2,4)],[Tb0(3,4) Tb1(3,4)])
% 
% plot3(Tb2(1,4), Tb2(2,4), Tb2(3,4), 'b*')
% line([Tb1(1,4) Tb2(1,4)],[Tb1(2,4) Tb2(2,4)],[Tb1(3,4) Tb2(3,4)])
% 
% plot3(Tb3(1,4), Tb3(2,4), Tb3(3,4), 'b*')
% line([Tb2(1,4) Tb3(1,4)],[Tb2(2,4) Tb3(2,4)],[Tb2(3,4) Tb3(3,4)])
% 
% plot3(Tb4(1,4), Tb4(2,4), Tb4(3,4), 'b*')
% line([Tb3(1,4) Tb4(1,4)],[Tb3(2,4) Tb4(2,4)],[Tb3(3,4) Tb4(3,4)])
% 
% plot3(Tb5(1,4), Tb5(2,4), Tb5(3,4), 'b*')
% line([Tb4(1,4) Tb5(1,4)],[Tb4(2,4) Tb5(2,4)],[Tb4(3,4) Tb5(3,4)])
% 
% plot3(Tb6(1,4), Tb6(2,4), Tb6(3,4), 'b*')
% line([Tb5(1,4) Tb6(1,4)],[Tb5(2,4) Tb6(2,4)],[Tb5(3,4) Tb6(3,4)])

% Отделяне на ротационните матрици от изразванита на коорд с-ми спрямо
% базовата
R00 = diag([1 1 1]);
R01 = Tb1(1:3,1:3);
R02 = Tb2(1:3,1:3);
R03 = Tb3(1:3,1:3);
R04 = Tb4(1:3,1:3);
R05 = Tb5(1:3,1:3);

% Разст м/у центровете на вс коорд с-ми спрямо базовата
d06 = Tb6(1:3,4);
d05 = Tb5(1:3,4);
d04 = Tb4(1:3,4);
d03 = Tb3(1:3,4);
d02 = Tb2(1:3,4);
d01 = Tb1(1:3,4);
d00 = [0;0;0];

% Изчислване на вс елементи от Якобиана от 1ви до 3ти ред и от 1ва до 6та
% колона
Jrow13col1 = cross(R00*[0;0;1],d06-d00);
Jrow13col2 = cross(R01*[0;0;1],d06-d01);
Jrow13col3 = cross(R02*[0;0;1],d06-d02);
Jrow13col4 = cross(R03*[0;0;1],d06-d03);
Jrow13col5 = cross(R04*[0;0;1],d06-d04);
Jrow13col6 = cross(R05*[0;0;1],d06-d05);

% Изчисл на вс елементи на Як от 4ти до 6ти ред и от 1ва до 6та колона
Jrow46col1 = R00*[0;0;1];
Jrow46col2 = R01*[0;0;1];
Jrow46col3 = R02*[0;0;1];
Jrow46col4 = R03*[0;0;1];
Jrow46col5 = R04*[0;0;1];
Jrow46col6 = R05*[0;0;1];
% Формиране на оконателния Якобиан
J = [Jrow13col1 Jrow13col2 Jrow13col3 Jrow13col4 Jrow13col5 Jrow13col6;
     Jrow46col1 Jrow46col2 Jrow46col3 Jrow46col4 Jrow46col5 Jrow46col6]
