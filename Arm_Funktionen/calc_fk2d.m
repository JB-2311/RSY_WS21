% RSY Projekt Tyr, berechnen der Position des Endeffektors von Achse 2-4.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_fk2d.m
% Erst Erstellung : 13.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm dient dem Berechnen der Endeffektor Position gesehen vom
% zweitem Gelenk bis zum Endeffektor. Es ist eine vereinfachte Vorwaerts
% Kinematik da diese nur in der RZ-Ebene berechnet.
%--------------------------------------------------------------------------
% Beispiel:
% pos_xy = calc_fk2d([0 -0.575 1.249 -0.674 1.57])
% theta : [theta1 theta2 theta3 theta4 theta5]
%====================================\/====================================

function pos_xy = calc_fk2d(theta)
% alpha_i d_i a_i theta_i => Denavit - Hartenberg Notation
dh = [
    0, 0, 155,   theta(2);
    0, 0, 35,    theta(3);
    0, 0, 217.5, theta(4);];
DH = [
    1, 0, 0;
    0, 1, 0;
    0, 0, 1;];
for i=1:3
    ScrewZ = [
        cos(dh(i,4)), -sin(dh(i,4)),  dh(i,3);
        sin(dh(i,4)),  cos(dh(i,4)),  0;
        0,             0,             1];
    DH = DH * ScrewZ;
end
pos_xy = DH(1:2,3);
end