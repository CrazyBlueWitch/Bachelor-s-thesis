clc;clear all;
rosinit("192.168.1.144")

sub = rossubscriber('/odom');
chatpub = rospublisher("/cmd_vel");
msg_p = rosmessage(chatpub);
i = 1;
while true
    msg = receive(sub);
    vel = msg.Twist.Twist.Linear.X;
    vel_50(i) = vel;
    msg.Pose.Pose.Position.X
    if msg.Pose.Pose.Position.X < 0
        msg_p.Linear.X = 0.05;
    else
        msg_p.Linear.X = 0;
    end
    i = i + 1;
    send(chatpub,msg_p);
end
