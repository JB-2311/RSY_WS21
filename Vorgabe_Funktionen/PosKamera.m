function [Objekt_Koord,Rolle]=PosKamera(ROS)
% Positionserkennungen mittels Kamera

% Hinterlegen kamerapositionen
%PosKamera_YB2 = [0 0 0 -pi/5 0];
PosKamera_Klotz = [2.8798 0 0 0 0.3491];

% Fallunterscheidung der Kreise YB gegenüber und Load 

% Klotz erkennen
GreiferPos(ROS, 0);
GelenkPos(ROS, PosKamera_Klotz);
Objekt_Koord = KreisErkennung(ROS,'w','1',20,'Dtol',5,'Sens',0.7,'Bild'); %30er Durchmesser fuer gesamten Klotz

lauschen=1;
while lauschen == 1
        Nachricht.Data =13;
        send(Publisher,Nachricht);
        try
        NaYB2 = receive(Subscriber, 0.1);
        NaYB2
        catch
        end
end

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







% YouBot erkennen

% GelenkPos(ROS, PosKamera_YB2);
% KreisErkennung(ROS,'s','2',20, 190,'Dtol',5,'Atol',10,'Sens',0.7,'Bild');


