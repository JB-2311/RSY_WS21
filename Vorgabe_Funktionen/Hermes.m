%Hermes Daten mittels UDP schreiben und lesen

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Karsten Flores
% Sebastian Flores
%--------------------------------------------------------------------------
% Hermes.m
% Version vom 10.12.2018
%--------------------------------------------------------------------------
% Daten Byte Austausch der YouBots
% - /ComByte_YB2       Kommunikationsbyte vom anderen YB (empfangen UDP)
% - /ComByte_YB1       Kommunikationsbyte vom eigenen YB (senden UDP)
%--------------------------------------------------------------------------
% im Terminal starten
% cd Dokumente/MATLAB/Grundbefehle
% /usr/local/MATLAB/R2018b/bin/matlab -nodesktop -nosplash -r Hermes
%====================================\/====================================
warning off;
%====================================/\====================================
%                                  ROS Init
%====================================\/====================================
rosshutdown;
rosinit('NodeName','Hermes');
Publisher=rospublisher('/YB2','std_msgs/Byte'); % an Main
Nachricht=rosmessage(Publisher);
Subscriber=rossubscriber('/YB1','std_msgs/Byte'); % von Main

%====================================/\====================================
%                                  Fenster
%====================================\/====================================
fontsz = 18;
HermesFenster=figure('Name','Hermes','NumberTitle','off','MenuBar','none');
textcreate(0.45,0.7,0.2,0.2,'YB1',fontsz,'center','middle','gre');
textcreate(0.45,0.1,0.2,0.2,'YB2',fontsz,'center','middle','red');
textcreate(0.55,0.5,0.0,0.0,'Hermes',fontsz,'center','middle','tra');
ellipsecreate(0.45,0.4,0.2,0.2,'blu');
textcreate(0.25,0.5,0.0,0.0,'Main',fontsz,'center','middle','tra');
ellipsecreate(0.15,0.4,0.2,0.2,'blu');
arrowcreate(0.55,0.4,0.55,0.3,'red');
arrowcreate(0.45,0.2,0.25,0.4,'red');
arrowcreate(1,0.45,0.637,0.45,'red');
arrowcreate(0.55,0.7,0.55,0.6,'gre');
arrowcreate(0.25,0.6,0.45,0.8,'gre');
arrowcreate(0.637,0.55,1,0.55,'gre');
textcreate(0.825,0.5,0.0,0.0,'UDP',fontsz,'center','middle','tra');
textcreate(0.2,0.9,0.0,0.0,'std\_msgs/Byte',fontsz,'center','middle','tra');
drawnow

%====================================/\====================================
%                                   UDP
%====================================\/====================================
ipS = '192.168.0.20'; % Ip des anderen PCs
% Verbindungsinfos
portS = 9091;
portM = 9190;
% Verbinden
udpVerbindung = udp(ipS,portS,'LocalPort',portM);
udpVerbindung.InputBufferSize=100;
fopen(udpVerbindung);

%====================================/\====================================
%               Loop der Daten lesen, schreiben und publishen
%====================================\/====================================
run=true;
while run
    % eigene Info auslesen und senden
    try
        Sub_Data=receive(Subscriber,0.1);
        fprintf(udpVerbindung, '%s', num2str(Sub_Data.Data));
    catch
        disp('ROS no data')
    end
    % andere Info empfangen und publishen
    try
        if udpVerbindung.BytesAvailable>0
            UDP_Data=fscanf(udpVerbindung);
            Nachricht.Data = str2double(UDP_Data);
            send(Publisher,Nachricht);
        end
    catch
        disp('UDP no data')
    end
    
    % in und output buffer loeschen
    flushinput(udpVerbindung);
    flushoutput(udpVerbindung);
    
    % falls Fenster geschlossen wird, run=false
    if ishandle(HermesFenster)==0
        run=false;
    end
    pause(0.0001);
end

%====================================/\====================================
%                           ENDE der Verbindungen
%====================================\/====================================
fclose(udpVerbindung);
delete(udpVerbindung);
rosshutdown;

disp('---Flores---')
% exit();

%====================================/\====================================
%                             Fenster Funktion
%====================================\/====================================
function textcreate(x,y,v,w,txt,fsize,HorAli,VerAli,theme)
switch theme
    case 'red'
        color.edge=[1 0 0];
        color.back=[0.94 0.94 0.94];
        color.font=[0 0 0];
    case 'gre'
        color.edge=[0 1 0];
        color.back=[0.94 0.94 0.94];
        color.font=[0 0 0];
    case 'blu'
        color.edge=[0 0 1];
        color.back=[0.94 0.94 0.94];
        color.font=[0 0 0];
    case 'tra'
        color.edge=[0.94 0.94 0.94];
        color.back=[0.94 0.94 0.94];
        color.font=[0 0 0];
    otherwise
end
annotation('textbox',...
    [x y v w],...
    'String',txt,...
    'FontSize',fsize,...
    'FontName','Arial',...
    'HorizontalAlignment',HorAli,...
    'VerticalAlignment',VerAli,...
    'LineStyle','-',...
    'EdgeColor',color.edge,...
    'LineWidth',1,...
    'BackgroundColor',color.back,...
    'Color',color.font);
end

function ellipsecreate(x,y,v,w,theme)
switch theme
    case 'red'
        color.edge=[1 0 0];
    case 'gre'
        color.edge=[0 1 0];
    case 'blu'
        color.edge=[0 0 1];
    otherwise
end
annotation('ellipse',...
    [x y v w],...
    'LineStyle','-',...
    'LineWidth',1,...
    'Color',color.edge);
end

function arrowcreate(x1,y1,x2,y2,theme)
switch theme
    case 'red'
        color.arrow=[1 0 0];
        line.style = '-';
        line.width = 1;
        line.head = 'plain';
    case 'gre'
        color.arrow=[0 1 0];
        line.style = '-';
        line.width = 1;
        line.head = 'plain';
    otherwise
end
annotation('textarrow',...
    [x1 x2],[y1 y2],...
    'LineStyle',line.style,...
    'LineWidth',line.width,...
    'HeadStyle',line.head,...
    'Color',color.arrow);
end