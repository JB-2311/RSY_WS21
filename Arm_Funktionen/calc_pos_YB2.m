% RSY Projekt Tyr, Berechnen der Position zum YB2.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_pos_YB2.m
% Erst Erstellung : 3.1.2019
%--------------------------------------------------------------------------
% Berechnung der Position des anderen YouBots mittels Punkte Daten der
% Kameraerkennung. 
%====================================\/====================================

function pos_YB2 = calc_pos_YB2(P1, P2, s)

if P1(2)>P2(2)
    PRechts = P2;
    PLinks = P1;
else
    PRechts = P1;
    PLinks = P2;
end

x1 = PLinks(1);
y1 = PLinks(2);
%z1 = PLinks(3);

x2 = PRechts(1);
y2 = PRechts(2);
%z2 = PRechts(3);

z = 0;

posYB2_temp = [(x1+x2)/2; (y1+y2)/2; z] + s * [y1-y2; x1-x2; z] * (1/(sqrt((x1-x2)^2 + (y1-y2)^2)));

pos_YB2(1) = posYB2_temp(1,1);
pos_YB2(2) = -posYB2_temp(2,1);
pos_YB2(3) = posYB2_temp(3,1);
end
