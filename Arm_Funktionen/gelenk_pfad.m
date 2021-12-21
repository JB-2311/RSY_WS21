% RSY Projekt Tyr, ansteuern eines Pfades.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% gelenk_pfad.m
% Erst Erstellung : 20.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm steuert nacheinander Winkelpositionen an.
%--------------------------------------------------------------------------
% Beispiel:
% pfad_theta_ges=calc_winkel([0  10 600 0 0; 5  5  550 0 0; 10 0  500 0 0])
% gelenk_pfad(ROS, pfad_theta, epsilon)
% epsilon : float % Toleranz
%====================================\/====================================

function gelenk_pfad(ROS, pfad_theta, epsilon)
for n = 1 : size(pfad_theta,1)
    gelenk_pos(ROS,pfad_theta(n,:),epsilon);
end
end