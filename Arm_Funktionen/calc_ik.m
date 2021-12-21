% RSY Projekt Tyr, berechnen der Winkelpositionen des YouBots aus XYZPsi.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_ik.m
% Erst Erstellung : 6.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm dient der Berechnung von Winkelpositionen aus vorher
% gegebenen X, Y, Z, Psi und Theta5 Daten. Dies ist somit eine Inverse
% Kinematik.
%--------------------------------------------------------------------------
% Beispiel:
% Lsg = calc_ik([33 0 600 0 pi])
% ee : [x y z psi theta5]
%====================================\/====================================

function Lsg = calc_ik(ee)
% in einfachere Variablen schreiben
x = ee(1);
y = ee(2);
z = ee(3);
psi = ee(4);
theta5 = ee(5);
% Arm Geometrie
l1 = 155;
l2 = 135;
l3 = 217.5;
% Ergebnis Matrix
Lsg = zeros(4,5);
% Theta 1 aller Ausrichtungen
Lsg(1:2,1) = atan2(y,x);
Lsg(3:4,1) = atan2(-y,-x);
for n = 0:2:2
    % Berechnungen von Theta 2 und 3
    Ez = z-147-cos(psi)*l3;
    % bei 1, 2 => 33 negativ und bei 3, 4 => 33 positiv
    Ey = sqrt(x^2+y^2)+((n-1)*33)-sin(psi)*l3;
    l = sqrt(Ez^2+Ey^2);
    alpha = acos((l1^2+l^2-l2^2)/(2*l1*l));
    gamma = acos((l1^2+l2^2-l^2)/(2*l1*l2));
    alphaNull = atan2(Ey,Ez);
    % Theta 2 und 3 zweier Ausrichtungen
    Lsg(1+n,2) = (n-1)*(-(alphaNull-alpha));
    Lsg(1+n,3) = (n-1)*(-(pi - gamma));
    Lsg(2+n,2) = (n-1)*(-(alphaNull+alpha));
    Lsg(2+n,3) = (n-1)*(pi - gamma);
    % Berechnungen von Theta 4
    Lsg(1+n,4) = (n-1)*(-psi) - Lsg(1+n,3) - Lsg(1+n,2);
    Lsg(2+n,4) = (n-1)*(-psi) - Lsg(2+n,3) - Lsg(2+n,2);
end
% setzen des eingebenen theta5
Lsg(:,5) = theta5;
end