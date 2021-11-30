%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arbeitsraumabschätzung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%clear all;

function Arbeitsraum(Position)
    % gewünschte Position übergeben
    %Position=[386 0 382 0 0];
    %Position=[386 0 302 0 0];
    %Position=[-345 0 362 0 0];
    %Position=[0 0 0 0 0];
    %Position=[33 0 654.5 pi/2 0]; %senkrecht nach oben
    %Position=[386  0 302 0 0]; %90° Winkel
    
    x=Position(1);
    y=Position(2);
    z=Position(3);
    psi=Position(4); %rad
    
    % Parameter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 0/1-Variable für Position innerhalb (1) oder außerhalb (0) des ARs
    klappt=0; % default: klappt nicht
        % Länge der Links
    l1=147;
    l2=155;
    l3=135;
    l4=217.5; 
    l5=0;
        % Versatz
    z_versatz=l1; % Versatz in z-Richtung
    
    if x>=33
        r_versatz=33; % Versatz in x-Richtung
    else
        r_versatz=-33;
    end
    % Theta 3 für maximalen Radius
    %theta3_maxR=0;
        % Theta 3 für minimalen Radius, Anschläge
    theta3_max=deg2rad(150);
    %theta3_min=deg2rad(-150);
        
    
    
    %Berechnung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Berechnung maximaler Arbeitsraum
    theta2=acos((z-z_versatz-l4*sin(psi))/(l2+l3)); %??????????????????
    r_max=508+r_versatz*sin(theta2)-l4; % maximaler Armradius
    %r_max=508; % maximaler Armradius
    theta4=(pi/2)-psi-theta2;
    r_aussen=sqrt((sqrt(x^2+y^2)-l4*cos(psi)-r_versatz)^2+(z-z_versatz)^2);
    %r_aussen=sqrt((z-z_versatz)^2+x^2+y^2)+l4*cos(theta4)-33*sin(theta2)
    
    % Berechnung minimaler Arbeitsraum
    l_23=sqrt(l2^2+l3^2-2*l2*l3*cos(pi-theta3_max));
    r_min=l_23; % +l4
    %r_2=sqrt((sqrt(x^2+y^2)-l4*cos(psi))^2+r_versatz^2);
    %z_2=z-z_versatz-l4*sin(psi);
    %r_innen=sqrt(r_2^2+z_2^2)
    
    % Position überprüfen
    if (r_aussen <= r_max) 
        klappt=1; % Position im AR
        disp('Klappt außen')
    %elseif (r_innen >= r_min)
    else
        klappt=0; % Position NICHT im AR
        disp('Gewünschte Position ist nicht im maximalen Arbeitsraum')
    end
    
    if (r_aussen >= r_min)
        klappt=1; % Position im AR
        disp('Klappt innen')
    else
        klappt=0; % Position NICHT im AR
        disp('Gewünschte Position ist nicht im minimalen Arbeitsraum')
    end
end

