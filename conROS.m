
function conROS(nodeName)

%ip=getIP();
ip='http://192.168.0.103:11311';

if (exist('nodeName','var'))
    %eingabe = nodeName
else
    nodeName='Matlab';
end

if robotics.ros.internal.Global.isNodeActive
    %schon aktiv nichts tun
else
    try
        %rosinit(ip.Local,'NodeName',nodeName); %Verbindung zum Masterserver
        rosinit(ip,'NodeName',nodeName); %Verbindung zum Masterserver
    catch
        %rosinit(ip.Net,'NodeName',nodeName); %Verbindung zum Masterserver
        rosinit(ip,'NodeName',nodeName); %Verbindung zum Masterserver
    end
end

end
