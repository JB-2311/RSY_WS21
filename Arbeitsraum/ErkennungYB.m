%% Positionserkennung des anderen YouBots mittels Kamera und Ausgabe der Punkte
function [P1,P2]=ErkennungYB(ROS)
    %% Position von YB2 Berechnen
    GelenkPos(ROS,[0, 0, 0, 0, 0]); % Kerzenposition anfahren
    GelenkPos(ROS,[0, pi/3, -pi/4, -pi/4, 0]); % in YB2-Erkennungsposition fahren 
    
    % Kreise erkennen
    YB2_Koord = KreisErkennung(ROS,'w','2',20,195,'Dtol',10,'Atol',20,'Sens',0.7,'Bild'); %Parameter optimiert für YB
     
    %% Kamera Koordinaten mithilfe von DH zu der Basis Umrechnen
    P1=calc_Trans_Kamera(YB2_Koord(1).X, YB2_Koord(1).Y, YB2_Koord(1).Z,0);
    P2=calc_Trans_Kamera(YB2_Koord(2).X, YB2_Koord(2).Y, YB2_Koord(2).Z,0);
    
    % x-, y-, & z-Koordinaten
    P1=[P1(1) P1(2) P1(3)];
    P2=[P2(1) P2(2) P2(3)];
    
    disp("Anderen YouBot erkannt")
end