% RSY Projekt Tyr, ansteuern eine Winkelposition.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% gelenk_pos.m
% Erst Erstellung : 20.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm steuert eine Winkelposition an.
%--------------------------------------------------------------------------
% Beispiel:
% gelenk_pos(ROS,[0 -0.575 1.249 -0.674 1.57],0.05)
% theta : [theta1 theta2 theta3 theta4 theta5]
% epsilon : float % Toleranz
%====================================\/====================================

function gelenk_pos(ROS,theta_in,epsilon)
JointValueMin = [-2.9496 -1.1345 -2.6354 -1.7802 -2.9147];
JointValueMax = [2.9496 1.5708 2.5482 1.7802 2.9147];
theta = zeros(1,5);
for i=1:5
    if i==3
        theta(i) = theta_in(i)-JointValueMax(i);
    else
        theta(i) = theta_in(i)-JointValueMin(i);
    end
end
theta = theta';
% Ansteuern mittels Pos-Befehl
for j=1:5
    ROS.Arm.Nach2.Positions(j).Value=theta(j);
end
% senden der geschriebenen Nachricht
send(ROS.Arm.Pub2,ROS.Arm.Nach2);
% warten bis Position erreicht wurde
epsilon_Array(1:5) = epsilon;
run = true;
while run
    data_Arm = receive(ROS.Arm.Sub);
    theta_cur = data_Arm.Position(1:5);
    if all(abs(theta - theta_cur) <= epsilon_Array)
        run = false;
    end
end
end
