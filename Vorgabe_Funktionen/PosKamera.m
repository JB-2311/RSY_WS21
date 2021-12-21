function PosKamera(ROS)
% Positionserkennungen mittels Kamera

% Hinterlegen kamerapositionen
%PosKamera_YB2 = [0 0 0 -pi/5 0];
PosKamera_Klotz = [2.8798 0 0 0 0.3491];

% Fallunterscheidung der Kreise YB gegenüber und Load 

% Klotz erkennen
GreiferPos(ROS, 0);
GelenkPos(ROS, PosKamera_Klotz);
Objekt_Koord = KreisErkennung(ROS,'w','1',20,'Dtol',5,'Sens',0.7,'Bild'); %30er Durchmesser fuer gesamten Klotz
Test=IK([-Objekt_Koord.Y -Objekt_Koord.X (Objekt_Koord.Z)+15 -(pi/2) 0]);
GelenkPos(ROS, Test);
GreiferPos(ROS, 20);
Test2=IK([-Objekt_Koord.Y -Objekt_Koord.X (Objekt_Koord.Z)-10 -(pi/2) 0]);
GelenkPos(ROS, Test2);
pause(5); % Warten auf Schließen des Greifers
GreiferPos(ROS, 0);
% Anfahren einer Beispiel-Übergabeposition
GelenkPos(ROS, [0 0 0 0 0]);

end







% YouBot erkennen

% GelenkPos(ROS, PosKamera_YB2);
% KreisErkennung(ROS,'s','2',20, 190,'Dtol',5,'Atol',10,'Sens',0.7,'Bild');


