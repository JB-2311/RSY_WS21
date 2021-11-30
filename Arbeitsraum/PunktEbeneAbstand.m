function PunktEbeneAbstand(pos_YB2, position_YB1_aktuell)
    %clear all
    Position=position_YB1_aktuell;
    pos_YB=pos_YB2;
    
    % Uebergabepunkt spaeter von Kamera
    r_PE = [pos_YB(1); pos_YB(2); 0];
    punkt = [Position(1); Position(2); Position(3)];
    
    % Einheitsvektor fuer Verrechnung der Matrizen
    z_EV = [0; 0; 1];
    
    % ortho1 = cross((r/2),z);
    ortho1 = cross(r_PE,z_EV);
    ortho2 = z_EV;
    
    %Ebene im Raum
    syms a b rho
    %Ebene = r/2 + a * ortho1 + b * ortho2;
    
    %Gerade im Raum; Laenge des Vektors
    FlaechenNormale = r_PE/norm(r_PE);
    %Gerade = punkt + rho*FlaechenNormale;
    
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
    else
        disp('zu nah an Ebene');
    end
end
 
