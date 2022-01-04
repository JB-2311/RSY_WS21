% Hermes starten: 
% $ cd /home/youbot/Schreibtisch/RSY_WS21/Vorgabe_Funktionen
% $ /home/youbot/Schreibtisch/MATLAB/bin/matlab -nodesktop -nosplash -r
% Hermes 
% $ roscore 
% $ roslaunch youbot_driver_ros_interface youbot_driver.launch 
% $ roslaunch astra_launch astra.launch 
% Matlab öffnen 
% rosinit() 
% ROS=runRos() 
% main.m starten


warning off;


createSerialLink_ZeroModify;

%Klotz erkennen und wenn einer da ist, dann greifen und senkrecht fahren &
%Rolle definieren (1 =Master, 0 = Slave)
[Klotz_Pos, Rolle]=PosKamera(ROS);

%Position YB2 auslesen
[Punkt_links, Punkt_rechts]=PosKamera_YB(ROS);

% Position des 2. YouBots mit Daten aus Kamera bestimmen
pos_YB=YB2_Pos_Bestimmung(Punkt_links, Punkt_rechts);

% Übergabehöhe berechnen
z_ueb=Uebergabehoehe(pos_YB,0); % mit Psi=0 als Übergabeorientierung

% Übergabe-Position unseres YB und Sicherheitsposition davor bestimmen
[Position_sicher, Position_ueb] =Uebergabeposition(pos_YB, z_ueb, 90, Rolle); %45

% Überprüfen, ob Positionen im Arbeitsraum liegen
Arbeitsraum(Position_sicher);
Arbeitsraum(Position_ueb);

frage_YouBotsErkannt='Beide YouBots haben einander erkannt? (1=ja, 0=nein)' 
antwort_YouBotsErkannt=input(frage_YouBotsErkannt)

% Sicherheitsposition anfahren, Orientierung EE je nach
% Master/Slave
[Winkel, Position]=IK(Position_sicher);
PunktEbeneAbstand(pos_YB, Position); %überprüft, ob gewünschter Punkt kollisionsgefährdet ist
GelenkPos(ROS, Winkel);
pause('on'); %Pause ermöglichen
pause(3); %für 3 Sekunden warten

if Rolle==1 %wenn Master und Klotz gegriffen, dann warten bis Slave in Übergabeposition ist und dann erst hinfahren
    frage_slaveDa='Slave-YouBot in Übergabeposition? (1=ja, 0=nein)'
    antwort_slaveDa=input(frage_slaveDa)
end
%wenn Slave, dann direkt Übergabeposition fahren 
    
% Übergabeposition auf gerader Linie anfahren, Orientierung EE je nach
% Master/Slave
schritte=20; % Anzahl Schritte
a=0:(1/schritte):1; 
a=transpose(a);
for i=1:schritte+1    % Schrittweise von Sicherheits- zu Übergabeposition
        Y=a*(Position_ueb(1:3)-Position_sicher(1:3));
        TKoordinate=Y+Position_sicher(1:3);
        
        Position(1)=TKoordinate(i,1);
        Position(2)=TKoordinate(i,2);
        Position(3)=TKoordinate(i,3);
        Position(4)=Position_sicher(4);
        Position(5)=Position_sicher(5);
        
        createSerialLink_ZeroModify;
        [Winkel]=IK(Position);
        GelenkPos(ROS, Winkel);
end


frage_uebergabe='Beide YouBots in Übergabeposition? (1=ja, 0=nein)'
antwort_uebergabe=input(frage_uebergabe)

if antwort_uebergabe==1 %beide YouBots in Übergabeposition
    %je nach Master (1) / Slave (0)
    if Rolle==1 %wenn Master und Klotz gegriffen, dann Greifer öffnen
        GreiferPos(ROS, 20); %Greifer öffnen
    else %wenn Slave, dann Greifer schließen
        GreiferPos(ROS, 0); %Greifer schließen
    end

    if Rolle==0 %wenn Slave, dann warten bis Master in Sicherheitsposition ist und dann erst wegfahren
        frage_masterWeg='Master-YouBot in Sicherheitsposition? (1=ja, 0=nein)'
        antwort_masterWeg=input(frage_masterWeg)
    end
    %wenn Master, dann direkt in Sicherheitsposition fahren 
    
    for i=1:schritte+1    % Schrittweise von Übergabe- zu Sicherheitsposition
        Y=a*(Position_sicher(1:3)-Position_ueb(1:3));
        TKoordinate=Y+Position_ueb(1:3);
        
        Position(1)=TKoordinate(i,1);
        Position(2)=TKoordinate(i,2);
        Position(3)=TKoordinate(i,3);
        Position(4)=Position_ueb(4);
        Position(5)=Position_ueb(5);
        
        createSerialLink_ZeroModify;
        [Winkel]=IK(Position);
        GelenkPos(ROS, Winkel);
    end

    frage_nachUebergabe='Beide YouBot in Sicherheitsposition? (1=ja, 0=nein)'
    antwort_nachUebergabe=input(frage_nachUebergabe)

    if Rolle==0 %wenn Slave, dann Klotz ablegen und in Kerze
        %Ablage-Position anfahren
        Ablage_Pos=IK([-191.06 -32.04 57.0625-10 -(pi/2) 0]) 
        GelenkPos(ROS, Ablage_Pos);
        GreiferPos(ROS, 20); %Greifer öffnen   
    end
    %wenn Master dann direkt in Kerze
    GelenkPos(ROS,[0, 0, 0, 0, 0]); %Kerzenposition  

end






