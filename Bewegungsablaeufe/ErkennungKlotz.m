%% Positionserkennung des Klotz mittels Kamera und Greifen des Klotzes
function [Objekt_Koord,Rolle]=ErkennungKlotz(ROS)
    % Kamerapositionen zum Erkennen hinterlegen
    PosKamera_Klotz = [2.8798 0 0 0 0.3491];
       
    % Klotz erkennen
    GreiferPos(ROS, 0);
    GelenkPos(ROS, PosKamera_Klotz); % Kamerapositionen zum Erkennen anfahren
    Objekt_Koord = KreisErkennung(ROS,'w','1',20,'Dtol',5,'Sens',0.7,'Bild'); %30er Durchmesser fuer gesamten Klotz
    
    % wenn ein Klotz erkannt wurde, dann Master-Rolle und greifen,
    % ansonsten Slave-Rolle
    if Objekt_Koord.X>0 
        disp("Klotz da, ich bin Master")
        Rolle=1; %Master-Rolle

        % Klotz greifen
        Winkel_Position_ueberKlotz=IK([-Objekt_Koord.Y -Objekt_Koord.X (Objekt_Koord.Z)+15 -(pi/2) 0]); 
        GelenkPos(ROS, Winkel_Position_ueberKlotz); % Punkt über Klotz anfahren
        GreiferPos(ROS, 20); % Greifer öffnen
        Winkel_Position_anKlotz=IK([-Objekt_Koord.Y-14 -Objekt_Koord.X-6 (Objekt_Koord.Z)-15 -(pi/2) 0]); %Koordinaten optimiert zum Greifen
        GelenkPos(ROS, Winkel_Position_anKlotz); % Punkt bei Klotz anfahren
        pause(5); % Warten auf Schließen des Greifers und Zeit zum Korrigieren der Klotzposition
        GreiferPos(ROS, 0); % Greifer schließen
        disp('Hab den Klotz')
       
        GelenkPos(ROS, [0 0 0 0 0]); % Kerzenposition        
    else
        disp("Ich bin Slave")
        Rolle=0; %Slave-Rolle

        GreiferPos(ROS, 20); %Greifer öffnen
    end
    
end