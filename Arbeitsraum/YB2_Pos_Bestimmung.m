EP_1 = [0 30 0]
EP_2 = [0 40 0]

s= (EP_1+EP_2)*0.5;
beta=atan2(EP_2(1),EP_2(2))
gamma=acos(-(norm(EP_1)^2+norm(EP_2)^2+norm(EP_1-EP_2)^2)/-(2*norm(EP_2)*norm(EP_1-EP_2)))
delta=beta+gamma-pi/2;

pos_YB=s+[s*cos(delta) s*sin(delta)]


