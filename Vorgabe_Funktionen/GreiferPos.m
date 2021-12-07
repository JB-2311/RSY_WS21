% Regler zum Verfahren des Greifers
function GreiferPos(ROS,varargin)
% den varargin mathematisch verarbeitbar machen
input=cell2mat(varargin);
% nach schauen ob eine oder beide Pos angegeben sind
% sowie berechnen der daraus folgende mm Eingaben
if size(input,2)==1
    if input>20
        input=20;
    elseif input<0
        input=0;
    end
    PosNeuMM=[input/2 input/2];
elseif size(input,2)==2
    for j=1:2
        if input(j)>10
            input(j)=10;
        elseif input(j)<0
            input(j)=0;
        end
    end
    PosNeuMM=[input(1) input(2)];
end
% Berechnen der Values der eingegebenden Position
PosNeuV=zeros(1,2);
for i=1:2
    PosNeuV(i)=interpolieren(...
        PosNeuMM(i),...
        ROS.Arm.Info.JointMin(5+i),...
        ROS.Arm.Info.JointMax(5+i),...
        ROS.Arm.Info.JointValueMin(5+i),...
        ROS.Arm.Info.JointValueMax(5+i));
end
% Schreiben und senden der Nachricht
for k=1:2
    ROS.Greifer.Nach.Positions(k, 1).Value=PosNeuV(k);
end
send(ROS.Greifer.Pub,ROS.Greifer.Nach);
% Weil in for schleife weiter definiert, hier vor definiert
Soll=zeros(1,2);
Ist=zeros(1,2);
deltaPos=zeros(1,2);
% EndToleranz
EndTol=0.00001;
% Programm arbeitet solange run=true
run=true;
while (run)
    % Soll/Ist Vergleich
    for l=1:2
        Soll(l)=PosNeuV(l);
        Ist(l)=ROS.Arm.Sub.LatestMessage.Position(5+l);
        deltaPos(l)=Soll(l)-Ist(l);
    end
    % Kontrolle ob Abstand zum Ziel klein ist
    if sum(abs(deltaPos))<(EndTol*2)
        run=false;
    end
    pause(0.1);
end
end