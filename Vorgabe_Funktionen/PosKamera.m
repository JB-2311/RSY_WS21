%% Positionserkennung des Klotz mittels Kamera und Greifen des Klotzes
function [Objekt_Koord,Rolle]=PosKamera(ROS)
    % Hinterlegen kamerapositionen
    PosKamera_Klotz = [2.8798 0 0 0 0.3491];
    
    % Fallunterscheidung der Kreise YB gegenüber und Load 
    
    % Klotz erkennen
    GreiferPos(ROS, 0);
    GelenkPos(ROS, PosKamera_Klotz);
    Objekt_Koord = KreisErkennung(ROS,'w','1',20,'Dtol',5,'Sens',0.7,'Bild'); %30er Durchmesser fuer gesamten Klotz
    
    if Objekt_Koord.X>0
        disp("Klotz da, ich bin Master")
        % Klotz greifen
        Test=IK([-Objekt_Koord.Y -Objekt_Koord.X (Objekt_Koord.Z)+15 -(pi/2) 0]);
        GelenkPos(ROS, Test);
        GreiferPos(ROS, 20);
        Test2=IK([-Objekt_Koord.Y -Objekt_Koord.X (Objekt_Koord.Z)-10 -(pi/2) 0]);
        GelenkPos(ROS, Test2);
        pause(5); % Warten auf Schließen des Greifers
        GreiferPos(ROS, 0);
        % Anfahren einer Beispiel-Übergabeposition
        GelenkPos(ROS, [0 0 0 0 0]);
        Rolle=1; %Master-Rolle
    else
        disp("Ich bin Slave")
        Rolle=0; %Slave-Rolle
        GreiferPos(ROS, 20); %Greifer öffnen
    end
    
end