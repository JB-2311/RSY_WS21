% RSY Projekt Tyr, berechnen der Position des Uebergabepunktes.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_Uebergabe.m
% Erst Erstellung : 27.11.2018
% Letzte Aenderung : 5.12.2018
% Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm dient der Berechnung des Uebergabepunktes zum andern YB.
%--------------------------------------------------------------------------
% Beispiel:
% [ueber_pos, pre_pos]= calc_Uebergabe([800,0], 10)
% pos_YB2 : [x y]
% Abstand : float
%====================================\/====================================

function [ueber_pos, pre_pos]= calc_Uebergabe(pos_YB2, Abstand, Teilnehmer)
ueber_pos(1) = pos_YB2(1)/2; %X
ueber_pos(2) = pos_YB2(2)/2; %Y
L1 = 147; % Abstand von Basis zur Drehachse Laenge l1
A1 = 33; % Verschiebung Achse 1 -> 2 auf der X-Achse
L4 = 217.5; % Laenger Achse 4 (Parallel zum Tisch)
L = 135 + 155; % + 217.5; % Maximale Armlaenge
hoehenFaktor = 0.8;
R = (pos_YB2(1)^2 + pos_YB2(2)^2)^0.5 - 2 * (A1 + L4);
% Z n% von maximaler Hoehe
ueber_pos(3) = hoehenFaktor * ((L^2 - (R/2)^2)^0.5 + L1);
alpha = atan2(ueber_pos(1),ueber_pos(2));
ueber_pos(4) = pi/2;
if strcmp(Teilnehmer, "Master")
    ueber_pos(5) = 0;
else
    ueber_pos(5) = pi/2;
end

ueber_pos(1) = ueber_pos(1) - sin(alpha) * 5;
ueber_pos(2) = ueber_pos(2) - cos(alpha) * 5;

pre_pos = ueber_pos;
pre_pos(1) = pre_pos(1) - sin(alpha) * Abstand;
pre_pos(2) = pre_pos(2) - cos(alpha) * Abstand;

end