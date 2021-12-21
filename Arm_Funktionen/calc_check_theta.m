% RSY Projekt Tyr, kontrolle von Winkelpositionen.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_check_theta.m
% Erst Erstellung : 13.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm dient der Kontrolle von Winkelpositionen, ob diese innerhalb
% der Min und Max Werte liegen und ob Rmin und Rmax eingehalten wird.
%--------------------------------------------------------------------------
% Beispiel:
% check = calc_check_theta([0 -0.575 1.249 -0.674 1.57])
% theta : [theta1 theta2 theta3 theta4 theta5]
%====================================\/====================================

function check = calc_check_theta(theta)
check = true; % erst auf true wenn irgendwas nicht passt false
% Arbeitraum Berechnung
l1 = 155;
l2 = 135;
l3 = 217.5;
Rmin = 50; % setzen auf einen minimalen Abstand zum Gelenk 2
Rmax = l1 + l2 + l3; % maximal machbarer Abstand vom Gelenk 2
ee_dir = calc_fk2d (theta);
R = sqrt(ee_dir(1)^2 + ee_dir(2)^2);
if R > Rmax || R < Rmin
    check = false;
end
% Winkel Kontrolle
JointValueMin = [-2.9496, -1.1345, -2.6354, -1.7802, -2.9147];
JointValueMax = [2.9496,   1.5708,  2.5482,  1.7802,  2.9147];
if any(theta > JointValueMax) || any(theta < JointValueMin)
    check = false;
end
% Real Kontrolle
if ~isreal(theta)
    check = false;
end
end