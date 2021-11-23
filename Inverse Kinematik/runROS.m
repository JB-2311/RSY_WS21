% zum testen des Arms ohne Hauptprogramm, 
% erstellen der Verbindung und der ROS-Struktur  
function ROS=runROS()%
%conROS();
pause(1); % kurzer Delay 
% Rosverbindungen
DepthSubscriber=rossubscriber('camera/depth/image','sensor_msgs/Image');
RGBSubscriber=rossubscriber('camera/rgb/image_raw','sensor_msgs/Image');
ArmPublisher = rospublisher ('arm_1/arm_controller/velocity_command','brics_actuator/JointVelocities');
ArmPublisher2 = rospublisher ('arm_1/arm_controller/position_command','brics_actuator/JointPositions');
ArmSubscriber = rossubscriber ('/joint_states','sensor_msgs/JointState');
GreiferPublisher = rospublisher ('arm_1/gripper_controller/position_command','brics_actuator/JointPositions');
% Arm Geschwindigkeits Struktur
ArmNachricht = rosmessage(ArmPublisher);    % Nachricht konfigurieren
for i=1:5                                   
    Gelenk(i) = rosmessage('brics_actuator/JointValue');    % Gelenk konfigurieren
    Gelenk(i).JointUri = ['arm_joint_' num2str(i)];         % Gelenk Nr
    Gelenk(i).Value = 0.0;                                  % Value
    Gelenk(i).Unit = 's^-1 rad';                            % Einheit
end
ArmNachricht.Velocities = Gelenk; % Nachricht verpacken 
% Arm Posistions Struktur
ArmNachricht2 = rosmessage(ArmPublisher2);    % Nachricht konfigurieren
for i=1:5                                   
    Gelenk(i) = rosmessage('brics_actuator/JointValue');    % Gelenk konfigurieren
    Gelenk(i).JointUri = ['arm_joint_' num2str(i)];         % Gelenk Nr
    Gelenk(i).Value = 0.0;                                  % Value
    Gelenk(i).Unit = 'rad';                                 % Einheit
end
ArmNachricht2.Positions = Gelenk;   % Nachricht verpacken 
% Greifer Positions Struktur
GreiferNachricht = rosmessage(GreiferPublisher);    % Nachricht konfigurieren
for j=1:2
    Greifer(j) = rosmessage('brics_actuator/JointValue');   % Greifer konfigurieren
    if j==1
        Greifer(j).JointUri = 'gripper_finger_joint_l';     % Greifer Links
    elseif j==2
        Greifer(j).JointUri = 'gripper_finger_joint_r';     % Greifer Rechts
    end
    Greifer(j).Value = 0;   % Value auf aktuell setzten
    Greifer(j).Unit = 'm';  % Einheit
end
GreiferNachricht.Positions = Greifer; % Nachricht verpacken
%Verpacken der Daten in eine leichter zu handhabende Struktur
ROS.Kamera.SubDepth=DepthSubscriber;
ROS.Kamera.SubRGB=RGBSubscriber;
ROS.Arm.Sub=ArmSubscriber;
ROS.Arm.Pub=ArmPublisher;
ROS.Arm.Nach=ArmNachricht;
ROS.Arm.Pub2=ArmPublisher2;
ROS.Arm.Nach2=ArmNachricht2;
ROS.Greifer.Pub=GreiferPublisher;
ROS.Greifer.Nach=GreiferNachricht;
%Arm Informationen
ROS.Arm.Info=infoArm();
end

% conRos startet die ROS Verbindung
function conROS(nodeName)
ip=getIP();
if (exist('nodeName','var'))
    % eingabe = nodeName
else
    nodeName='Matlab';
end
if robotics.ros.internal.Global.isNodeActive
    % schon aktiv nichts tun
else
    % Verbindung zum Masterserver
    try
        rosinit(ip.Local,'NodeName',nodeName); 
    catch
        rosinit(ip.Net,'NodeName',nodeName);
    end
end
end

% getIp zum Erhalten der aktuellen Ip
function ip=getIP()
% Mittels Systembefehl wird Verbindung ausgelesen
[~,result]=system('ifconfig | grep "inet Adresse"');
% Der ausgelesende String wird getrennt und gespeichert
str=strsplit(result,{' ',':'});
try
    ip.Net=char(str(9));
catch
    ip.Net='0.0.0.0';
end
ip.Local=char(str(4));
end

% Min Max sowie Up/Mid Positionen aller Gelenke und des Greifers
function Out=infoArm()
% Gelenke Min Max Winkel
JointMin=[-169 -65 -151 -102 -167 0 0];
JointMax=[169 90 146 102 167 10 10];
% Spezielle Positionen Winkel
JointRes=[-169 -65 146 -102 -167 0 0];
JointUp=[0 0 0 0 0 0 0];
% Gelenke Min Max Werte Treiber
JointValueMin=round([0.0100692 0.0100692 -5.02655 0.0221239 0.110619 0 0]+0.00005,4);
JointValueMax=round([5.84014 2.61799 -0.015708 3.4292 5.64159 0.0115 0.0115]-0.00005,4);
JointValueUp=zeros(1,7);
JointValueRes=zeros(1,7);
% Berechnen der Speziellen Positionen Werte Treiber 
for i=1:5
    if i==3
        JointValueUp(i)=deg2rad(JointUp(i)-(JointMax(i)'));
        JointValueRes(i)=deg2rad(JointRes(i)-(JointMax(i)'));
    else
        JointValueUp(i)=deg2rad(JointUp(i)-(JointMin(i)'));
        JointValueRes(i)=deg2rad(JointRes(i)-(JointMin(i)'));
    end
end
for i=1:5
    if JointValueUp(i)>JointValueMax(i)
        JointValueUp(i)=JointValueMax(i);
    elseif JointValueUp(i)<JointValueMin(i)
        JointValueUp(i)=JointValueMin(i);
    end
    if JointValueRes(i)>JointValueMax(i)
        JointValueRes(i)=JointValueMax(i);
    elseif JointValueRes(i)<JointValueMin(i)
        JointValueRes(i)=JointValueMin(i);
    end
end
%for i=6:7
 %   JointValueUp(i)=interpolieren(JointUp(i),JointMin(i),JointMax(i),JointValueMin(i),JointValueMax(i));
 %   JointValueRes(i)=interpolieren(JointRes(i),JointMin(i),JointMax(i),JointValueMin(i),JointValueMax(i));
%end
% Verpacken in Struktur
Out=struct(...
    'JointMin',JointMin,...
    'JointMax',JointMax,...
    'JointUp',JointUp,...
    'JointRes',JointRes,...
    'JointValueMin',JointValueMin,...
    'JointValueMax',JointValueMax,...
    'JointValueRes',JointValueRes,....
    'JointValueUp',JointValueUp);
end



