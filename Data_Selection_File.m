load('NMC_Cell1_35Deg.mat')
load('NMC_Cell1_25Deg.mat')
load('NMC_Cell1_05Deg.mat')
load('LFP_Cell1_35Deg.mat')
load('LFP_Cell1_25Deg.mat')
load('LFP_Cell1_05Deg.mat')
Data_Selct = input("Select a data \n 1. LFP  1C 35 deg \n 2. LFP  2C 35 deg \n 3. LFP  1C 25 deg \n 4. LFP  2C 25 deg \n 5. LFP  1C 05 deg \n 6. LFP  2C 05 deg \n 7. NMC  1C 35 deg \n 8. NMC  2C 35 deg \n 9. NMC  1C 25 deg \n 10. NMC  2C 25 deg \n 11. NMC  1C 05 deg \n 12. NMC  2C 05 deg \n Enter Number from 0 to 12:");

% %-------------------- LFP 35 DegC -------------------%
% %------------------------C/20-------------------------%
if  (Data_Selct == 1 ||  Data_Selct ==2)
Tx = LFP_005C_35degC(:,1);
Ix = -LFP_005C_35degC(:,2);
Vx = LFP_005C_35degC(:,3);
end
% %------------------------C-------------------------%clc
if (Data_Selct ==1)
T = LFP_1C_35degC(:,1);
I = -LFP_1C_35degC(:,2);
V = LFP_1C_35degC(:,3);
end
% %------------------------2C-------------------------%
if (Data_Selct ==2)
T = LFP_2C_35degC(:,1);
I = -LFP_2C_35degC(:,2);
V = LFP_2C_35degC(:,3);
end
% % -------------------- LFP 25 DegC -------------------%
% %------------------------C/20-------------------------%
if  (Data_Selct == 3 ||  Data_Selct ==4)
% Tx = LFP_005C_25degC(:,1);
% Ix = -LFP_005C_25degC(:,2);
% Vx = LFP_005C_25degC(:,3);
end
% %------------------------C-------------------------%
if (Data_Selct ==3)
T = LFP_1C_25degC(:,1);
I = -LFP_1C_25degC(:,2);
V = LFP_1C_25degC(:,3);
end
% %------------------------2C-------------------------%
if (Data_Selct ==4)
T = LFP_2C_25degC(:,1);
I = -LFP_2C_25degC(:,2);
V = LFP_2C_25degC(:,3);
end
% % -------------------- LFP 05 DegC -------------------%
% %------------------------C/20-------------------------%
if  (Data_Selct == 5 ||  Data_Selct == 6)
Tx = LFP_005C_05degC(:,1);
Ix = -LFP_005C_05degC(:,2);
Vx = LFP_005C_05degC(:,3);
end
% %------------------------C-------------------------%
if (Data_Selct ==5)
T = LFP_1C_05degC(:,1);
I = -LFP_1C_05degC(:,2);
V = LFP_1C_05degC(:,3);
end
% %------------------------2C-------------------------%
if (Data_Selct ==6)
% T = LFP_2C_05degC(:,1);
% I = -LFP_2C_05degC(:,2);
% V = LFP_2C_05degC(:,3);
end
% 
% 
% % -------------------- NMC 35 DegC ------------------%
% %------------------------C/20-------------------------%
if  (Data_Selct == 7 ||  Data_Selct == 8)
Tx = NMC_005C_35degC(:,1);
Ix = -NMC_005C_35degC(:,2);
Vx= NMC_005C_35degC(:,3);
end
% %------------------------C-------------------------%
if (Data_Selct ==7)
T = NMC_1C_35degC(:,1);
I = -NMC_1C_35degC(:,2);
V = NMC_1C_35degC(:,3);
end
% %------------------------2C-------------------------%
if (Data_Selct ==8)
T = NMC_2C_35degC(:,1);
I = -NMC_2C_35degC(:,2);
V = NMC_2C_35degC(:,3);
end
%  
% % --------------------  NMC 25 DegC ------------------%
% %------------------------C/20-------------------------%
if  (Data_Selct == 9 ||  Data_Selct == 10)
Tx = NMC_005C_25degC(:,1);
Ix = -NMC_005C_25degC(:,2);
Vx = NMC_005C_25degC(:,3);
end
% %------------------------C-------------------------%
if (Data_Selct ==9)
T = NMC_1C_25degC(:,1);
I = -NMC_1C_25degC(:,2);
V = NMC_1C_25degC(:,3);
end
% %------------------------2C-------------------------%
if (Data_Selct ==10)
T = NMC_2C_25degC(:,1);
I = -NMC_2C_25degC(:,2);
V = NMC_2C_25degC(:,3);
end
%   
%  
% % -------------------- NMC 05 DegC -------------------%
% %------------------------C/20-------------------------%
if  (Data_Selct == 11 ||  Data_Selct == 12)
Tx = NMC_005C_05degC(:,1);
Ix = -NMC_005C_05degC(:,2);
Vx = NMC_005C_05degC(:,3);
end
% %------------------------C-------------------------%
if (Data_Selct ==11)
T = NMC_1C_05degC(:,1);
I = -NMC_1C_05degC(:,2);
V = NMC_1C_05degC(:,3);
end
% %------------------------2C-------------------------%
if (Data_Selct ==12)
T = NMC_2C_05degC(:,1);
I = -NMC_2C_05degC(:,2);
V = NMC_2C_05degC(:,3);
end

