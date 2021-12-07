% Funktion zum Interpolieren
% Wert einer Skala in eine Skala umrechnen
function Out=interpolieren(In,Min1,Max1,Min2,Max2)
Out=round((In-Min1)/(Max1-Min1)*(Max2-Min2)+Min2,4);
end