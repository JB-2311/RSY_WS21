% RSY Projekt Tyr, einen Pfad der Ik einzelen uebergeben.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_winkel.m
% Erst Erstellung : 13.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm gibt der Ik aus einer Kette von Positionen einzelne
% Positionen Schritt fuer Schritt.
%--------------------------------------------------------------------------
% Beispiel:
% pfad_theta_ges=calc_winkel([0  10 600 0 0; 5  5  550 0 0; 10 0  500 0 0])
% pfad_xyz : [theta;theta;...]
% theta : [theta1 theta2 theta3 theta4 theta5]
%====================================\/====================================

function pfad_theta_ges = calc_winkel(pfad_xyz)
for n = 1 : size(pfad_xyz,1)
    Lsg = calc_ik(pfad_xyz(n,:));
    pfad_theta_ges(1).pfad_theta(n,:) = Lsg(1,:);
    pfad_theta_ges(2).pfad_theta(n,:) = Lsg(2,:);
    pfad_theta_ges(3).pfad_theta(n,:) = Lsg(3,:);
    pfad_theta_ges(4).pfad_theta(n,:) = Lsg(4,:);
end
end