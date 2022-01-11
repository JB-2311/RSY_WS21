%% YouBot verfährt linear von einem Punkt zum anderen
function LinearBewegung(ROS,startPunkt,endPunkt, anzahlSchritte)
    schritte=anzahlSchritte; % Anzahl Schritte (20)
    a=0:(1/schritte):1; 
    a=transpose(a);
    for i=1:schritte+1    % Schrittweise von Start- zu Endposition
        Y=a*(endPunkt(1:3)-startPunkt(1:3));
        TKoordinate=Y+startPunkt(1:3);
        
        Position(1)=TKoordinate(i,1);
        Position(2)=TKoordinate(i,2);
        Position(3)=TKoordinate(i,3);
        Position(4)=startPunkt(4);
        Position(5)=startPunkt(5);
        
        createSerialLink_ZeroModify;
        [Winkel]=IK(Position);
        GelenkPos(ROS, Winkel);
    end
end