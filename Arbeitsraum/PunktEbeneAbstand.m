clear all
r = [0 200 0];
punkt = [0 400 0]
x = [1 0 0];
y = [0 1 0];
z = [0 0 1];

ortho1 = cross(r,z);
ortho2= z;

syms a b rho
%Ebene im Raum
%Ebene = r/2 + a * ortho1 + b * ortho2;
%Grade im Raum
FlaechenNormale = r/norm(r);
%Grade = punkt + rho*FlaechenNormale;

Vektor = punkt - r/2;

Matrix = [ortho1; ortho2; FlaechenNormale]
KoeffzientenVektor = transpose([a b rho])

%L�sung der Gleichtung Matrix * KoeffzientenVektor = Vektor
KoeffzientenVektor = inv(Matrix) * transpose(Vektor)
rho = KoeffzientenVektor(3)
Schnittpunkt = punkt - rho*FlaechenNormale;


Abstand = norm(Schnittpunkt - punkt)
 