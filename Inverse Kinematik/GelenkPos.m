% Regler zum Verfahren der Gelenke
function GelenkPos(ROS,WinkelNeuR)
WinkelNeuD=rad2deg(WinkelNeuR);
WinkelNeuV=zeros(1,5);
% Max Min Abgleich und Korektur der Eingabe
for i=1:5
    if WinkelNeuD(i)>ROS.Arm.Info.JointMax(i)
        WinkelNeuD(i)=ROS.Arm.Info.JointMax(i);
    elseif WinkelNeuD(i)<ROS.Arm.Info.JointMin(i)
        WinkelNeuD(i)=ROS.Arm.Info.JointMin(i);
    end
    % wenn nan nimm den Aktuellen Winkel, sonst berechne Value
    if ~isnan(WinkelNeuD(i))
        if i==3
            WinkelNeuV(i)=deg2rad(WinkelNeuD(i)-(ROS.Arm.Info.JointMax(i)'));
        else
            WinkelNeuV(i)=deg2rad(WinkelNeuD(i)-(ROS.Arm.Info.JointMin(i)'));
        end
    else
        WinkelNeuV(i)=ROS.Arm.Sub.LatestMessage.Position(i);
    end
    
end
% Max Min Abgleich und Korektur der Values
for i=1:5
    if WinkelNeuV(i)>ROS.Arm.Info.JointValueMax(i)
        WinkelNeuV(i)=ROS.Arm.Info.JointValueMax(i);
    elseif WinkelNeuV(i)<ROS.Arm.Info.JointValueMin(i)
        WinkelNeuV(i)=ROS.Arm.Info.JointValueMin(i);
    end
end

% SollSp und EndSp sowie EndToleranz
SollSp=[0 0 0 0 0];
EndSp=0.01;
EndTol=0.01;
% Min Max
MinSp=0.1;
MaxSp=0.5;
% Regler
KP=[.9 .9 .7 .9 .5];
% KP=[1.2 .9 .7 .9 .5];
% Programm arbeitet solange run=true
run=true;
while (run)
    WinkelAltV(1:5)=ROS.Arm.Sub.LatestMessage.Position(1:5);
    % Soll/Ist Vergleich
    Soll=WinkelNeuV;
    Ist=WinkelAltV;
    deltaPos=Soll-Ist;
    for j=1:5
        if abs(deltaPos(j))>EndTol
            % P-Regler reicht weil die Regelstrecke I Anteil besitzt
            SollSp(j)=deltaPos(j)*KP(j);
            % Speed Min und Max
            if abs(SollSp(j))<MinSp
                if SollSp(j)<0
                    SollSp(j)=-MinSp;
                else
                    SollSp(j)=MinSp;
                end
            elseif abs(SollSp(j))>MaxSp
                if SollSp(j)<0
                    SollSp(j)=-MaxSp;
                else
                    SollSp(j)=MaxSp;
                end
            end
            % schreiben der errechneten Geschwindigkeit in die Nachricht
            ROS.Arm.Nach.Velocities(j).Value=SollSp(j);
        else
            ROS.Arm.Nach.Velocities(j).Value=0.0;
        end
    end
    % Kontrolle ob Geschwindigkeiten und Abstand zum Ziel klein ist
    if sum(abs(ROS.Arm.Sub.LatestMessage.Velocity))<EndSp && sum(abs(deltaPos))<(EndTol*5)
        for k=1:5
            ROS.Arm.Nach.Velocities(k).Value=0.0;
        end
        run=false;
    end
    % senden der geschriebenen Nachricht
    send(ROS.Arm.Pub,ROS.Arm.Nach);
    pause(0.01);
end
% Nachkorrektur mittels Pos-Befehl
for j=1:5
    ROS.Arm.Nach2.Positions(j).Value=WinkelNeuV(j);
end
% senden der geschriebenen Nachricht
send(ROS.Arm.Pub2,ROS.Arm.Nach2);
% Kontrolle ob Geschwindigkeiten kleiner EndSp sind
run=true;
EndSp=0.01;
while run
    if sum(abs(ROS.Arm.Sub.LatestMessage.Velocity))<EndSp/10
        run=false;
    end
    pause(0.01);
end
end
