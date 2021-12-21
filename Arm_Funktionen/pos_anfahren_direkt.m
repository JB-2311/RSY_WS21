% RSY Projekt Tyr, eine Position direkt anfahren, mit allen Kontrollen.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% pos_anfahren_direkt.m
% Erst Erstellung : 14.1.2019
%--------------------------------------------------------------------------
% Das Programm faehrt eine Position an, davor fuehrt es alle noetigen
% Unterprogramme aus.
%====================================\/====================================

function pos_anfahren_direkt(ROS,pos)
theta_temp = calc_winkel(pos);
pos_theta = kontrolle(theta_temp);
GelenkPos(ROS, rad2deg(pos_theta));
end