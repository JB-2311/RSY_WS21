Position=[386 30 272 0 0];
x=Position(1);
y=Position(2);
z=Position(3);
psi=Position(4); %rad

% Versatz & Link-Längen:
    % alpha
alpha1=0;
alpha2=pi/2;
alpha3=0;
alpha4=0;
alpha5=pi/2;
    % d
d1=0;
d2=33;
d3=0;
d4=0;
d5=0;
    % a
a1=147;
a2=155;
a3=135;
a4=217.5;
a5=0;
    % l (Länge der Links)
l2=155;
l3=135;
l4=217.5; 

% Berechnung Theta_1
theta1=atan2(y,x)

% Berechnung Theta_2 & _3    
r=sqrt(x^2+y^2); % Distanz r zum x,y-Urpsrung
z1=z-a1; % Distanz z zum x,y-Urpsrung

r=r-d2;

d=sqrt((r-l4*cos(psi))^2+(z1-l4*sin(psi))^2)

alpha=atan2((z1-l4*sin(psi)),(r-l4*cos(psi)))

gamma=acos((-d^2+l2^2+l3^2)/(2*l2*l3))

theta3=-(gamma-pi)

delta=asin((sin(gamma)*l3)/d)

theta2=pi/2-(alpha+delta)

% Berechnung Theta_4
theta4=psi-theta2+theta3 -(pi/2) 
theta4 = -theta4
% Theta_5 aus Angabe
theta5=Position(5);

%theta3=-theta3 % Drehrichtung umgekehrt

Winkel=([theta1 theta2 theta3 theta4 theta5])