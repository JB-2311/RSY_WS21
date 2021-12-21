% RSY Projekt Tyr, Daten aus Hermes lesen.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% KomFcn.m
% Erst Erstellung : 11.12.2018
%--------------------------------------------------------------------------
% Teil des Hauptprogrammes welches die Kommunikation mit Hermes 
% bereitstellt. Wird durch den Timer alle X-Sekunden aufgerufen 
%====================================\/====================================


function KomFcn(timer, ~)
timer.UserData.ROS.Hermes.Nach.Data = bin2dec(timer.UserData.send);
send(timer.UserData.ROS.Hermes.Pub,timer.UserData.ROS.Hermes.Nach);
end