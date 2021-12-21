% RSY Projekt Tyr, interpolieren zwischen mehreren Punkten.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% kom_pfad.m
% Erst Erstellung : 20.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm macht zwischen mehreren Punkten lineare Interpolationen.
%--------------------------------------------------------------------------
% Beispiel:
% pfad_xyz = kom_pfad([0 10 600 0 0; 10 0 600 0 0; 0 10 500 0 0], 1)
% Punkte : [x,y,z,phi,theta5; x,y,z,phi,theta5; ...]
% MaxSchritt : float
%====================================\/====================================

function pfad_xyz = kom_pfad(Punkte, MaxSchritt)
pos2 = 1;
letzterPunkt = Punkte(1,:);
for n = 1 : size(Punkte,1)-1
    if letzterPunkt == Punkte(n+1,:)
        error("Aufeinander folgende Punkte sind identisch")
    end
    
    temp_pfad_xyz = calc_lin_pfad(Punkte(n,:), Punkte(n+1,:), MaxSchritt);
    pos1 = size(temp_pfad_xyz,1)-1;
    pfad_xyz(pos2:pos1+pos2,:) = temp_pfad_xyz;
    pos2 = size(pfad_xyz,1);
    
    letzterPunkt = Punkte(n+1,:);
end
end