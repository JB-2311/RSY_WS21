% RSY Projekt Tyr, alle vier Moeglichen Pfade kontrollieren.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% kontrolle.m
% Erst Erstellung : 13.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm geht die moeglichen Pfade durch und gibt zum Ende einen
% verfahrbaren Weg aus, falls es einen gibt.
%--------------------------------------------------------------------------
% Beispiel:
% pfad_xyz = kom_pfad([0 10 600 0 0; 10 0 600 0 0; 0 10 500 0 0], 1);
% pfad_theta_ges=calc_winkel(pfad_xyz);
% pfad_theta=kontrolle(pfad_theta_ges)
%====================================\/====================================

function pfad_theta=kontrolle(pfad_theta_ges)
flag = false;
checkArray = zeros(4,size(pfad_theta_ges(1).pfad_theta,1));
for n = 1 : size(pfad_theta_ges,2)
    for m = 1 : size(pfad_theta_ges(1).pfad_theta,1)
        checkArray(n,m) = calc_check_theta(pfad_theta_ges(n).pfad_theta(m,:));
    end
    if all(checkArray(n,:))
        pfad_theta = pfad_theta_ges(n).pfad_theta;
        flag = true;
        break % erster/letzter Weg der okay ist
    end
end

if ~flag
    error("Kein Fahrbarer Weg!")
end
end