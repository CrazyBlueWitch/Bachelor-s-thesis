clc;clear all;
rosinit("192.168.1.198")

sub = rossubscriber('/j2s6s300_driver/out/joint_angles')

i = 1;
while true
    msg = receive(sub);
    joint1(i) = msg.Joint1;
    joint2(i) = msg.Joint2;
    joint3(i) = msg.Joint3;
    joint4(i) = msg.Joint4;
    joint5(i) = msg.Joint5;
    joint6(i) = msg.Joint6;
    i = i + 1;
end
