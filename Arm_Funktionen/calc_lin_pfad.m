% RSY Projekt Tyr, interpolation zwischen zwei Punkte.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% calc_lin_pfad.m
% Erst Erstellung : 13.11.2018
% Letzte Aenderung : 5.12.2018
%	Aenderung : Clean up
%--------------------------------------------------------------------------
% Das Programm dient der Interpolation zwischen zwei gegebenen Punkten, es
% muss dabei die Maximale Schrittgroesse angegeben werden.
%--------------------------------------------------------------------------
% Beispiel:
% pfad_xyz = calc_lin_pfad([0 10 600 0 0], [10 0 500 0 pi], 50)
% Start und Ende : [x,y,z,psi,theta5]
% MaxSchritt : float
%====================================\/====================================

function pfad_xyz = calc_lin_pfad(Start, Ende, MaxSchritt)
anz = max(abs(ceil((Ende-Start)/MaxSchritt)));
if anz == 0
    anz = 1;
end
Schritt = (Ende-Start)/anz;
pfad_xyz = zeros(anz,5);
for n = 1 : anz+1
    pfad_xyz(n,:) = Start + Schritt * (n-1);
end

end