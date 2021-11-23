%createSerialLink;
createSerialLink_ZeroModify;

mittelP_y=0; %Mittelpunkt Y
mittelP_z=302; %Mittelpunkt Z

Position=[386 0 282 0 0]; %Positions-Variable initiieren 

Radius=30;
p0=[386 mittelP_y mittelP_z];

schritte=50; % Anzahl Schritte
a=0:(1/schritte):1; 
a=transpose(a);
TKoordinate=a*p0;

% Schleife
for i=1:schritte+1    
    %TKoordinate=a*p0;
    TKoordinate(i,1)=p0(1);
    TKoordinate(i,2)=p0(2)+Radius*cos(2*pi*a(i));
    TKoordinate(i,3)=p0(3)+Radius*sin(2*pi*a(i));
    Position(1)=TKoordinate(i,1);
    Position(2)=TKoordinate(i,2);
    Position(3)=TKoordinate(i,3);
    
    createSerialLink_ZeroModify;
    IK;

    %set(gcf,'Visible','on');
    %YouBot.plot(Winkel);
    GelenkPos(ROS, Winkel)
end
% X = TKoordinate(:,1);
% Y = TKoordinate(:,2);
% Z = TKoordinate(:,3);
% plot3(X,Y,Z,'*')
