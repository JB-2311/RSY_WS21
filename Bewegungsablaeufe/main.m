
%% Notwendige Schritte vor Ausführung des Programms:
% $ roscore 
% $ roslaunch youbot_driver_ros_interface youbot_driver.launch 
% $ roslaunch astra_launch astra.launch 
% Matlab öffnen 
% in Command Window ausführen: rosinit() 
% in Command Window ausführen: ROS=runRos() 
% main.m starten

%% Haupt-Programm für Übergabe eines Klotzes zwischen zwei YouBots
warning off; % Warnungen ausschalten für übersichtlichere Ausgaben in Command Window

createSerialLink_ZeroModify; % Referenzieren

% Klotz erkennen und wenn einer da ist, dann greifen und senkrecht fahren &
%Rolle definieren (1 =Master, 0 = Slave)
[Klotz_Pos, Rolle]=ErkennungKlotz(ROS);

%Wiederholt probieren Position der Marker an YB2 zu erkennen
erkennen=0;
while (~erkennen) % Immer wieder versuchen den anderen YouBot zu erkennen bis kein Fehler mehr
    try
        [Punkt_links, Punkt_rechts]=ErkennungYB(ROS); % YouBot2 erkennen        
        erkennen=1;  % Versuche beenden, wenn Position von YouBot2 erkannt wurde          
    catch % bei Fehler, dann:
        disp("Keiner da? Hilfe!")
        continue % neuen Durchlauf von while-Loop starten
    end
end

% Position des 2. YouBots mittels erkannter Marker-Punkte bestimmen
pos_YB=YB2_Pos_Bestimmung(Punkt_links, Punkt_rechts);

% Übergabehöhe berechnen
z_ueb=Uebergabehoehe(pos_YB,0); % mit Psi=0 als Übergabeorientierung (???)

% Übergabe-Position unseres YB und Sicherheitsposition davor bestimmen & Greifer entsprechend der Rolle orientieren
[Position_sicher, Position_ueb] =Uebergabeposition(pos_YB, z_ueb, 90, Rolle); 

% Überprüfen, ob Positionen im Arbeitsraum liegen
Arbeitsraum(Position_sicher);
Arbeitsraum(Position_ueb);

% Eingabeaufforderung damit die YouBots sich bei der Erkennung nicht gegenseitig die
% Sicht versperren und aufeinander warten
frage_YouBotsErkannt='Beide YouBots haben einander erkannt? (1=ja, 0=nein)' 
antwort_YouBotsErkannt=input(frage_YouBotsErkannt)

if antwort_YouBotsErkannt==1 %beide YouBots haben Erkennung abgeschlossen, dann Übergabe initiieren    
    % Überprüfen, ob Sicherheitsposition kollisionsgefährdet mit der senkrechten Mittelebene zwischen den YouBots ist
    PunktEbeneAbstand(pos_YB, Position_sicher); 

    % Sicherheitsposition anfahren, Orientierung des EE je nach Master-/Slave-Rolle
    Winkel_Position_sicher=IK(Position_sicher);    
    GelenkPos(ROS, Winkel_Position_sicher);
    pause('on'); % Pause ermöglichen
    
    if Rolle==1 %wenn Master-Rolle und Klotz gegriffen, dann warten bis Slave in Übergabeposition ist und dann erst hinfahren
        % Eingabeaufforderung damit Slave zuerst bei Übergabeposition ist
        frage_slaveDa='Slave-YouBot in Übergabeposition? (1=ja, 0=nein)'
        antwort_slaveDa=input(frage_slaveDa)
    end
    %wenn Slave, dann direkt in Übergabeposition fahren 
        
    % Von Sicherheitsposition aus die Übergabeposition auf gerader Linie
    % anfahren (in 20 Schritten), Orientierung des EE je nach Master-/Slave-Rolle
    LinearBewegung(Position_sicher,Position_ueb, 20);
    
    % Eingabeaufforderung Übergabe
    frage_uebergabe='Beide YouBots in Übergabeposition? (1=ja, 0=nein)'
    antwort_uebergabe=input(frage_uebergabe)
    
    if antwort_uebergabe==1 %beide YouBots in Übergabeposition
        %je nach Master (1) / Slave (0)
        if Rolle==1 %wenn Master & Klotz gegriffen, dann Greifer öffnen
            GreiferPos(ROS, 20); %Greifer öffnen
        else %wenn Slave, dann Greifer schließen
            GreiferPos(ROS, 0); %Greifer schließen
        end
    
        if Rolle==0 %wenn Slave, dann warten bis Master in Sicherheitsposition ist und dann erst wegfahren
            frage_masterWeg='Master-YouBot in Sicherheitsposition? (1=ja, 0=nein)'
            antwort_masterWeg=input(frage_masterWeg)
        end
        %wenn Master, dann direkt in Sicherheitsposition fahren 
        
        % Von Übergabeposition aus die Sicherheitsposition auf gerader Linie anfahren (in 20 Schritten), Orientierung des EE je nach Master-/Slave-Rolle
        LinearBewegung(Position_ueb, Position_sicher, 20);
    
        % Eingabeaufforderung zur Kollisionsvermeidung nach Übergabe
        frage_nachUebergabe='Beide YouBot in Sicherheitsposition? (1=ja, 0=nein)'
        antwort_nachUebergabe=input(frage_nachUebergabe)
    
        if Rolle==0 %wenn Slave, dann Klotz ablegen & danach in Kerze
            % Ablage-Position anfahren
            Ablage_Pos=IK([-191.06 -32.04 57.0625-10 -(pi/2) 0]) 
            GelenkPos(ROS, Ablage_Pos);
            % Greifer öffnen
            GreiferPos(ROS, 20); 
            disp('Klotz abgelegt')
        end

        %wenn Master dann direkt in Kerze
        GelenkPos(ROS,[0, 0, 0, 0, 0]); %Kerzenposition  
        disp('FERTIG')
    end
end






