%live bild
window=figure;
run=true;
while run
    try
        %Ausgabe = KreisErkennung(ROS,'s','2',20,190,'Dtol',5,'Atol',1,'Sens',0.9,'Bild');
        %fprintf("%f  %f\n",Ausgabe(1).X, Ausgabe(2).X)
        
        Ausgabe = KreisErkennung(ROS,'s','1',21,'Bild','Sens',0.8);
        
%         Ausgabe = KreisErkennung(ROS,'s','1',21,'Bild','Sens',0.8);
%         if ~isempty(Ausgabe(1).X)
%             for i = 1 : length(Ausgabe)
%                 position(i).Data = KoordinatenTransKameraYoubot(Ausgabe(i).X,Ausgabe(i).Y,Ausgabe(i).Z,0);
%             end
%             P1 = [position(1).Data(1) position(1).Data(2) position(1).Data(3)];
%             P2 = [position(2).Data(1) position(2).Data(2) position(2).Data(3)];
%             pos_YB2 = calc_pos_YB2(P1, P2, 120);
%             disp(pos_YB2);
%         end
        
        
        %KreisErkennung(ROS,'s','2',21,57,'Bild');
        %KreisErkennung(ROS,'s','2',21,112,'Bild');
    catch
    end
    pause(0.1);
    if ~ishandle(window)
        run=false;
    end
end
