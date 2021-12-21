
%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% calc_Trans_Kamera.m
% Erst Erstellung : 7.1.2019
%--------------------------------------------------------------------------
% Transformation der Kameraerkennungsdaten
%====================================\/====================================

function pos=calc_Trans_Kamera(xYoubot,yYoubot,zYoubot,theta1)

alpha=pi/4;             % Der Winkel von der Senkrechten des Endeffektors

d=-72; 
a=415; 

theta=-theta1-pi/2;

RotX=[                  % Drehen um X, um auf die gerade Ebene zu drehen 
    1,0,0,0;
    0,cos(alpha),-sin(alpha),0;
    0,sin(alpha),cos(alpha),0;
    0,0,0,1];

TransZ=[                % Verschub nach oben
    1,0,0,0;
    0,1,0,0;
    0,0,1,d;
    0,0,0,1];

RotZ=[                  % Drehen um Z, um auf das richtige Koordinatensystem zu kommen 
    cos(theta),-sin(theta),0,0;
    sin(theta),cos(theta),0,0;
    0,0,1,0;
    0,0,0,1];

TransY=[                % Verschub nach vorne 
    1,0,0,0;
    0,1,0,a;
    0,0,1,0;
    0,0,0,1];

punkt=[xYoubot;yYoubot;zYoubot;1];

pos=TransZ*RotZ*TransY*RotX*punkt;
