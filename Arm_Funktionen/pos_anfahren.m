% RSY Projekt Tyr, einen Pfad anfahren, mit allen Kontrollen.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% pos_anfahren.m
% Erst Erstellung : 4.12.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm faehrt einen Pfad an, davor fuehrt es alle noetigen
% Unterprogramme aus.
%--------------------------------------------------------------------------
% Beispiel:
% pos_anfahren(ROS, [0 10 500 0 0; 10 0 600 0 0], 0.1, 0.5,[800 0],10)
% Schrittweite : float
% epsilon : float
% pos_YB2 : [x y]
% minAbstand : float
%====================================\/====================================

function pos_anfahren(ROS, pfad, Schrittweite, epsilon, pos_YB2, minAbstand)
% Pfad erstellen
pfad_xyz_ges = kom_pfad(pfad,Schrittweite);
% Pfad kontrollieren zur Kollision
pfad_xyz = kontrolle_ebene(pfad_xyz_ges,pos_YB2,minAbstand);
% ik => XYZ in Thetas umrechnen
pfad_theta_ges=calc_winkel(pfad_xyz);
% kontrolle winkel, Rmin und Rmax
pfad_theta=kontrolle(pfad_theta_ges);
% senden der Positionen an GelenkPosition
gelenk_pfad(ROS, pfad_theta, epsilon);
end