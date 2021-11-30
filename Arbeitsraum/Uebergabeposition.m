function [Position_sicher, Position_ueb]=Uebergabeposition(position_YB2, uebergabehoehe, abstand)
    pos_YB=position_YB2;
    z_ueb=uebergabehoehe;
    
    % Berechnung der Übergabeposition (x2 y2 z_ueb)
    theta1=atan((pos_YB(2)/pos_YB(1)));
    r_ueb=sqrt((pos_YB(2))^2+(pos_YB(1))^2);
    x2=cos(theta1)*(r_ueb/2);
    y2=sin(theta1)*(r_ueb/2);    

    Position_ueb=[x2 y2 z_ueb 0 0]; 

    % Berechnung der Sicherheitsposition (x_s y_s z_ueb) vor der Übergabeposition 
    r_ueb_sicher=r_ueb-abstand;
    x_s=cos(theta1)*(r_ueb_sicher/2);
    y_s=sin(theta1)*(r_ueb_sicher/2);
    
    Position_sicher=[x_s y_s z_ueb 0 0]; 
    
end