clc;
clear all;
close all;
Data_Selection_File;
DAH = 0;
CAH = 0;
s = size(V);

for j=1:s(1)
    if I(j) > 0
        DAH = DAH + I(j)/3600;
    end
    if I(j) < 0 
        CAH =  CAH - I(j)/3600;
    end
end

sx = size(Vx);
Ts = 1/3600;    % new sample at every one second
n = 0;

for k = 1:sx(1)
    if Ix(k) >0
        n=n+1;
        Vz(n) = Vx(k);
        Iz(n) = Ix(k);
    end
end
sz  =size(Vz);
SoC_LC_old = 1;
eta =1;
for k = 1:sz(2)
    SoC_LC(k) = SoC_LC_old - eta*Ts *Iz(k)/CAH; 
    SoC_LC_old = SoC_LC(k);
end

R0 =  zeros(s);
R1 =  zeros(s);
C1 =  zeros(s);
Voc = zeros(s);
e=  zeros(s);
Vc = zeros(s);


% LFP cell informtion
 slop  =110 ;
 eta = 1;
 Cn =  2.6;
 Tx  =  1/3600;
 

%State Space Formation for OCV and Param
Xes = [2.5;1e-4;1e-5;100];   % state vector of OCV R0 R1 C1
P =[1 0 0 0;0 10e-1 0 0; 0 0 0 10e-1;0 0 0 1]; % state covariance Mmatrix
%P = eye(4)*10;
A =  eye(4);   % Matrix A
B= [0;0;0;0] ;   % -mn Del T/ Cn 
Q = eye(4)/100;
R = 5e-6;

for i=1:s(1)
    if i ==1
        Vc_old  =  0;
        SoC_CC_old =0;
        Vold =V(1);
        Iold = 0;
        R0old =Xes(2);
        R1old =Xes(3);
        C1old =Xes(4);
    else 
        Vc_old = Vc(i-1);
        SoC_CC_old = SoC_CC(i-1);
        Vold = V(i-1);
        Iold = I(i-1);
        R0old = R0(i-1);
        R1old = R1(i-1);
        C1old = C1(i-1);
    end
    if I(i)> 0
        eta =1;
    else
        eta =  0.998;
    end
      SoC_CC(i) =  SoC_CC_old -  eta*I(i)*Tx/CAH;
        a1 = exp(-1/(Xes(3)*Xes(4)));
      Vc(i) = Vc_old * a1  + Xes(3)*I(i)*(1-a1);
      if abs(V(i)-Vold) < 100e-3
         slop = (V(i) - Vold) + Xes(2)*(I(i) - Iold) + Vc(i)-Vc_old;
      else 
          slop = 0;
      end
      B = [slop;0;0;0] ;
         
     %Time Update
     Xes=A*Xes+B;
     P=A*P*A'+ Q;    
     a1 = exp(-1/(Xes(4)));
     Vc(i) = Vc_old * a1  + Xes(3)*I(i)*(1-a1);
     Vpr(i) =  Xes(1) - I(i)*Xes(2) - Vc(i); 
     e(i) = V(i)-Vpr(i);
     a12 = -I(i) * (exp(1/Xes(4)^2)-1);
     a13 = (1/Xes(4)^2)*(Vc(i) - Xes(3)*I(i))*exp(1/Xes(4));
     J = [1 -I(i) -a12 -a13 ]; % Jacobian Matrix     
     Pyy=J*P*J'+R;
     K=P*J'/(Pyy+1e-3);
     Xes = Xes + K*(e(i));%posterior mean
     P=P-K*J*P; %posterior covarience 
     trac(i) = trace(P);

     Voc(i) = Xes(1);
     R0(i) = Xes(2);
     R1(i) = Xes(3);
     C1(i) = Xes(4);
end
figure('Color','white')
plot(V,'r','linewidth',2)
hold on 
plot(Vpr,'b','linewidth',2)
hold on
plot(Voc,'g','linewidth',2)
legend('Terminal Voltage','Estiamtated Voltage','Open Circuit Voltage');
xlabel('Time (s)','FontSize',16)
ylabel('Voltage (V)','FontSize',16)
set(gca,"FontSize",16)
ylim([2.5,4.5]);
 
 
figure('Color','white')
plot(I)
xlabel('Time (s)','FontSize',16)
ylabel('Current (I)','FontSize',16)
set(gca,"FontSize",16)


figure('Color','white')
plot(e,'r','linewidth',2)
xlabel('Time (s)','FontSize',16)
ylabel('Error (V)','FontSize',16)
set(gca,"FontSize",16)

figure('Color','white')
plot(SoC_CC,Voc,'r','linewidth',2);
hold on 
plot(SoC_LC,Vz,'b','linewidth',2);
legend('Estimated OCV', 'LCO Test OCV');
xlabel('SoC','FontSize',16)
ylabel('Open Circuit Voltage (V)','FontSize',16)
set(gca,"FontSize",16)