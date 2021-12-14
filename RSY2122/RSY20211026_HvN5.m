%createSerialLink;
createSerialLink_ZeroModify;

versatz_y=30; %Versatz vom Mittelpunkt aus
versatz_z=30; %Versatz vom Mittelpunkt aus
mittelP_y=0; %Mittelpunkt Y
mittelP_z=302; %Mittelpunkt Z

Position=[386 0 282 0 0]; %Positions-Variable initiieren 

    % Punkte angeben für Haus vom Nikolaus
p0=[386 mittelP_y-versatz_y mittelP_z-versatz_z];
p1=[386 mittelP_y-versatz_y mittelP_z+versatz_z];
p2=[386 mittelP_y+versatz_y mittelP_z+versatz_z];
p3=p0;
p4=[386 mittelP_y+versatz_y mittelP_z-versatz_z];
p5=p1; 
p6=[386 mittelP_y mittelP_z+2*versatz_z];
p7=p2;
p8=p4;

Punkte=[p0; p1; p2; p3; p4; p5; p6; p7; p8]; % Punkte für Schleife speichern

schritte=50; % Anzahl Schritte
a=0:(1/schritte):1; 
a=transpose(a);

for n=1:8
    for i=1:schritte+1    
        Y=a*(Punkte(n+1,1:3)-Punkte(n,1:3));
        TKoordinate=Y+Punkte(n,1:3);
        
        Position(1)=TKoordinate(i,1);
        Position(2)=TKoordinate(i,2);
        Position(3)=TKoordinate(i,3);
        
        createSerialLink_ZeroModify;
        RSY20211026_IK_HvN2;
    
        %set(gcf,'Visible','on');
        %YouBot.plot(Winkel);
        GelenkPos(ROS, Winkel)
    end
end