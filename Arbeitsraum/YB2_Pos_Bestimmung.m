function [pos_YB]=YB2_Pos_Bestimmung(Punkt_links, Punkt_rechts)
    EP_1 = Punkt_links;
    EP_2 = Punkt_rechts;
    
    s= (EP_1+EP_2)*0.5;
    beta=atan2(EP_2(1),EP_2(2));
    gamma=acos((norm(EP_1)^2-norm(EP_2)^2-norm(EP_1-EP_2)^2)/-(2*norm(EP_2)*norm(EP_1-EP_2)));
    delta=beta+gamma-pi/2;;
    
    
    pos_YB=s+[norm(s)*cos(delta) norm(s)*sin(delta) 0];
end




