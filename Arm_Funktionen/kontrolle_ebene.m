% RSY Projekt Tyr, einen Pfad kontrollieren.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% kontrolle_ebene.m
% Erst Erstellung : 13.11.2018
% Letzte Aenderung : 5.12.2018
% Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm kontrolliert einen kompletten Pfad ob dieser die
% Kollisionsebene zu dem anderen YB hin schneidet.
%--------------------------------------------------------------------------
% Beispiel:
% pfad_xyz_ges = kom_pfad([0 10 600 0 0; 10 0 600 0 0; 0 10 500 0 0], 1);
% pfad_xyz = kontrolle_ebene(pfad_xyz_ges,[800 0],10)
% pos_YB2 : [x y]
% minAbstand : float
%====================================\/====================================

function pfad_xyz = kontrolle_ebene(pfad_xyz_ges,pos_YB2,minAbstand)
flag = false;
checkArray = zeros(size(pfad_xyz_ges,1),1);
for m = 1 : size(pfad_xyz_ges)
    checkArray(1,m) = calc_check_Abstand(pfad_xyz_ges(m,1:3),pos_YB2, minAbstand);
end
if all(checkArray(1,:))
    pfad_xyz = pfad_xyz_ges;
    flag = true;
end
if ~flag
    error("Abstand zum anderen YouBot wurde unterschritten!")
end
end