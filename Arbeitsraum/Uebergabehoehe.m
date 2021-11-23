% Berechnungsskript für die Übergabehöhe 

% l (Länge der Links)
l2=155;
l3=135;
l4=217.5;

% Variablen zum Test, später per Kamera
x_ueb=pos_YB(1);
y_ueb=pos_YB(2);
psi=0;

% Übergabehöhe bestimmen
theta2_ueb=asin((0.5*sqrt(x_ueb^2+y_ueb^2)-33-l4*cos(psi))/(l2+l3))
z_max=147+l4*sin(psi)+(l2+l3)*cos(theta2_ueb)
z_ueb=0.7*z_max