% RSY Projekt Tyr, berechnen ob die Kollisionsebene geschnitten wird.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_check_Abstand.m
% Erst Erstellung : 20.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm dient der Kontrolle ob eine Position die Kollisonsebene
% schneidet. Dafuer wird die XYZ-Position, der Abstand zum anderen YB und
% der minimale Abstand der eingehalten werden soll.
%--------------------------------------------------------------------------
% Beispiel:
% check = calc_check_Abstand([200,0,300], [800,0], 10)
% ee_YB1 : [x y z]
% pos_YB2 : [x y]
% minAbstand : float
%====================================\/====================================

function check = calc_check_Abstand(ee_YB1, pos_YB2, minAbstand)
check = true; % erst auf true wenn irgendwas nicht passt false
% variablen in simpler umpacken
delta_x = pos_YB2(1);
delta_y = pos_YB2(2);
Px = ee_YB1(1);
Py = ee_YB1(2);
Pz = 0;
P = [Px; Py; Pz];
% Ebene aufspannen
r = [delta_x; delta_y; 0];
rHalb = r/2;
%z = [0 0 1];
n = rHalb;
% Matrixen aufstellen
A = [
    0,  delta_y/2, -delta_x/2;
    0, -delta_x/2, -delta_y/2;
    1,  0,         0;];
t = [
    Px - delta_x/2;
    Py - delta_y/2;
    Pz - 0];
% Lsg berechnen
Lsg = A\t;%Lsg = inv(A) * t;
%a = Lsg(1);
%b = Lsg(2);
sig = Lsg(3);
% Abstand berechnen und kontrolieren
Schnittpunkt = P + sig * n;
Abstand = (Schnittpunkt - P);
Abstand_Mag = sqrt(Abstand(1)^2 + Abstand(2)^2);
if Abstand_Mag <= minAbstand || sig < 0
    check = false;
end
end