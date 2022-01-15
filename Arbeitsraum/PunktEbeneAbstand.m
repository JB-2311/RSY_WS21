function [Signal_PunktEbene]=PunktEbeneAbstand(position_YB2, position_YB1_gewuenscht)
    Position=position_YB1_gewuenscht;
    pos_YB=position_YB2;

    Signal_PunktEbene=0; % default: Abbruch von main, weil Position nicht genügend Abstand hat
    
    % Uebergabepunkt von Kamera
    r_PE = [pos_YB(1); pos_YB(2); 0]; % Vektor in x-y-Ebene
    punkt = [Position(1); Position(2); Position(3)]; % Koordinaten des gewünschten Punkt übergeben
    
    % Einheitsvektor fuer Verrechnung der Matrizen
    z_EV = [0; 0; 1];

    ortho1 = cross(r_PE,z_EV);
    ortho2 = z_EV;
    
    %Ebene im Raum
    syms a b rho
       
    %Gerade im Raum; Laenge des Vektors
    FlaechenNormale = r_PE/norm(r_PE);
        
    Vektor = punkt - r_PE/2;
    
    Matrix = [ortho1 ortho2 FlaechenNormale];
    KoeffzientenVektor = [a b rho];
    
    %Loesung der Gleichtung Matrix * KoeffzientenVektor = Vektor
    KoeffzientenVektor = inv(Matrix) * Vektor;
    rho = KoeffzientenVektor(3);
    Schnittpunkt = punkt - rho*FlaechenNormale;
    
    Abstand = norm(Schnittpunkt - punkt);
    
    % Abfrage über minimalen Grenzabstand
    if Abstand > 20
        disp('weit genug von Ebene entfernt');
        Signal_PunktEbene=1; % Position hat genügend Abstand
    else
        disp('zu nah an Ebene');
        Signal_PunktEbene=0; % Abbruch von main, weil Position nicht genügend Abstand hat
    end
end
 
