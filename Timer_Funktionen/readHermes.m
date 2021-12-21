% RSY Projekt Tyr, Daten aus Hermes lesen.

%====================================/\====================================
% Westfaelische Hochschule - FB Maschinenbau
% Labor fuer Mikroelektronik und Robotik
%--------------------------------------------------------------------------
% Martin Kondring
% Sebastian Flores
% Karsten Flores
%--------------------------------------------------------------------------
% readHermes.m
% Erst Erstellung : 11.12.2018
%--------------------------------------------------------------------------
% Teil des Hauptprogrammes welches die gesendeten Daten aus Hermes liest
%====================================\/====================================


function receiveData = readHermes(ROS)
try
    if ~ROS.Debug.Komm
        SubData = receive(ROS.Hermes.Sub, 1);
        tempReceive = dec2bin(SubData.Data);
    else
        sBuffer = input("Nachricht vom anderen youBot [0, 1, 3, 4, 9, 16]: ",'s');
        tempReceive = dec2bin(str2double(sBuffer));
    end
    tempStr = '';
    for i=1:8-length(tempReceive)
        tempStr = strcat(tempStr,'0');
    end
    receiveData = strcat(tempStr,tempReceive);
catch
    receiveData = "00000000";
end
end
