%%%Funktion, die aus den von der Kamera erfassten Markern die Position des
%%%anderen YouBots bestimmt.
function [pos_YB]=YB2_Pos_Bestimmung(Punkt_links, Punkt_rechts)
    EP_1 = Punkt_links;
    EP_2 = Punkt_rechts;

    s=110; %Abstand von Mittelpunkt zwischen Markern zu YB2 Position
    m= (EP_1+EP_2)*0.5; %Mittelpunkt zwischen Markerpositionen
    

    %beta=atan2(EP_2(1),EP_2(2))
    beta=atan(EP_2(2)/EP_2(1));
    gamma=acos((norm(EP_2)^2+norm(EP_1-EP_2)^2-norm(EP_1)^2)/(2*norm(EP_2)*norm(EP_1-EP_2)));
    delta=beta+gamma-pi/2;  

    pos_YB=m+[s*cos(delta) s*sin(delta) 0];
end




