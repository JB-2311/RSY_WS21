%Min Max sowie Up/Mid Positionen aller Gelenke und des Greifers
%erweiterbar mit anfahrbaren Pos?

function Out=infoArm()

    JointMin=[-169 -65 -151 -102 -167 0 0];
    JointMax=[169 90 146 102 167 10 10];
    JointRes=[-169 -65 146 -102 -167 0 0];
    JointUp=[0 0 0 0 0 0 0];

    JointValueMin=round([0.0100692 0.0100692 -5.02655 0.0221239 0.110619 0 0]+0.00005,4);
    JointValueMax=round([5.84014 2.61799 -0.015708 3.4292 5.64159 0.0115 0.0115]-0.00005,4);
    JointValueUp=zeros(1,7);
    JointValueRes=zeros(1,7);
    for i=1:7
        JointValueUp(i)=interpolieren(JointUp(i),JointMin(i),JointMax(i),JointValueMin(i),JointValueMax(i));
        JointValueRes(i)=interpolieren(JointRes(i),JointMin(i),JointMax(i),JointValueMin(i),JointValueMax(i));
    end

    Out=struct(...
        'JointMin',JointMin,...
        'JointMax',JointMax,...
        'JointUp',JointUp,...
        'JointRes',JointRes,...
        'JointValueMin',JointValueMin,...
        'JointValueMax',JointValueMax,...
        'JointValueRes',JointValueRes,....
        'JointValueUp',JointValueUp);
end
