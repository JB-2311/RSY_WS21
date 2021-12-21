%% Position von YB2 Berechnen
s = 120;                                   % 110mm der Abstand
GelenkPos(ROS,[0, 0, 0, 0, 0]);
GelenkPos(ROS,[0, pi/3, -pi/4, -pi/4, 0]); % YB2 Erkennungsposition Fahren 

liveBild_YB2;                              % Marke erkennen von der YouBot2

%% Kamera Koordinaten mithilfe von DH zu der Basis Umrechnen
P1=calc_Trans_Kamera(PaketPos_YB2_r1.X,PaketPos_YB2_r1.Y,PaketPos_YB2_r1.Z,0);
P2=calc_Trans_Kamera(PaketPos_YB2_r2.X,PaketPos_YB2_r2.Y,PaketPos_YB2_r2.Z,0);

pos_YB2 = calc_pos_YB2(P1, P2, s);
GelenkPos(ROS,[0, 0, 0, 0, 0]); 