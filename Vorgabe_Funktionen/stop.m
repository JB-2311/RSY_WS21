% Zum Stoppen des Arms, auch falls noch keine Verbindung besteht
function stop()
conROS();   % Verbinden
pause(0.1); % kurzer Delay
ArmPublisher = rospublisher ('arm_1/arm_controller/velocity_command',...
'brics_actuator/JointVelocities');
ArmSubscriber = rossubscriber ('/joint_states','sensor_msgs/JointState');
ArmNachricht = rosmessage(ArmPublisher); % Nachricht konfigurieren
for i=1:5
    Gelenk(i) = rosmessage('brics_actuator/JointValue');    % Gelenk konfigurieren
    Gelenk(i).JointUri = ['arm_joint_' num2str(i)];         % Gelenk Nr
    Gelenk(i).Value = 0.0;                                  % Value
    Gelenk(i).Unit = 's^-1 rad';                            % Einheit
end
ArmNachricht.Velocities = Gelenk;           % Nachricht verpacken
send(ArmPublisher,ArmNachricht);            % Nachricht senden
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