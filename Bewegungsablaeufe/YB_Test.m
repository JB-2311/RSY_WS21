%createSerialLink;
createSerialLink_ZeroModify;

% Postition des anderen YB
pos_YB=[1000 0 300 0 0];
theta1=atan((pos_YB(2)/pos_YB(1)));
r_ueb=sqrt((pos_YB(2))^2+(pos_YB(1))^2)

% Übergabehöhe berechnen
Uebergabehoehe;

% Position unseres YB
x2=cos(theta1)*(r_ueb/2);
y2=sin(theta1)*(r_ueb/2);
Position=[x2 y2 z_ueb 0 0]; %Positions-Variable initiieren 

schritte=20; % Anzahl Schritte
a=0:(1/schritte):1; 
a=transpose(a);

% später in Bewegungsschleife, da Werte immer aktualisiert werden müssen
Arbeitsraum;
PunktEbeneAbstand;

createSerialLink_ZeroModify;
IK;
GelenkPos(ROS, Winkel);

% for i=1:schritte+1    
%     TKoordinate=Y+Punkte(n,1:3);
%     Position(1)=TKoordinate(i,1);
%     Position(2)=TKoordinate(i,2);
%     Position(3)=TKoordinate(i,3);
%     
%     createSerialLink_ZeroModify;
%     IK;
%     
%     %set(gcf,'Visible','on');
%     %YouBot.plot(Winkel);
%     GelenkPos(ROS, Winkel)
% end
