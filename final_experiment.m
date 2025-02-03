clc; close all; clear all;
rosinit('192.168.1.198')
% този файл се генерира след умножение на инвърснати Якобиан с целевите
% скорости по 3те оси на манипулатора, които целеви стойности се генерират
% от мобилната платформа Kuka youBot. 
load('new_final_vals.mat')

% Дефинираме ROS topic по който ще изпращаме данни за скоростите на
% ставите на манипулатора.
vel_topic = rospublisher('/j2s6s300_driver/in/joint_velocity');
% Дефиниране на съобщение, което ще съдържа стойностите за скоростите.
vel_msg = rosmessage(vel_topic);

% цикъла for се изпълнява толкова пъти колкото е дължината на вектора
% kinova_vel.
for i = 1:length(kinova_vel)
%      Подаване на пресметнатите стойности на движение на ставите на
%      манипулатора, които скорости осигуряват постоянна позиция на
%      работния орган при подвижна база.
    vel_msg.Joint1 = 0;
    vel_msg.Joint1 = rad2deg(kinova_vel(1,i));
    vel_msg.Joint2 = rad2deg(kinova_vel(2,i))*2.145; % 1.3;
    vel_msg.Joint3 = rad2deg(kinova_vel(3,i))*1.8975;  % 1.15;
    vel_msg.Joint4 = rad2deg(kinova_vel(4,i));
    vel_msg.Joint5 = rad2deg(kinova_vel(5,i));
    vel_msg.Joint6 = rad2deg(kinova_vel(6,i));
%     изпращане на стойностите към ставите. 
    send(vel_topic, vel_msg); 
end

% x 0.2108; y -0.2657; z 0.5035
rosshutdown
