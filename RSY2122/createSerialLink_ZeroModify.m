%% This Script creates a SerialLink object of the KUKA youBot with      
% the DH parameters

% The SerialLink object YouBot has to be in the MATLAB workspace, for       
% using the plot/simulation function of the robotarm

% clear the current workspace before using this script
%clear all

% create Links with the DH-parameters
L(1) = Link([0   1.47   0.33    pi/2    0       0   ]);
L(2) = Link([0   0      1.55    0       0       pi/2   ]);
L(3) = Link([0   0      1.35    0       0       0   ]);
L(4) = Link([0   0      0       pi/2    0       pi/2   ]);
L(5) = Link([0   2.175  0       0       0       0 ]);

% create SerialLink object YouBot
YouBot = SerialLink(L, 'name', 'YouBot');

% save the current workspace variables into a .mat file for further
% usage
save('YouBot_Modell.mat');