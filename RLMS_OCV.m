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

eta = DAH/CAH;
R0 =  zeros(s);
R1 =  zeros(s);
C1 =  zeros(s);
Voc = zeros(s);
e=  zeros(s);
R0(1) = 0.1;
R1(1) = 0.01;
C1(1) = 1000;
Voc(1) = 2.5;

den = (1 + 2*R1(1)*C1(1))
theta(2) = -((1 - (2*R1(1)*C1(1)))/den);
theta(1) = (1-theta(2))*Voc(1);
theta(3) = -((R0(1) +R1(1) + 2*R1(1)*C1(1)*R0(1))/den);
theta(4) = -((R0(1) +R1(1)- 2*R1(1)*C1(1)*R0(1))/den);
theta = [theta(1);theta(2);theta(3);theta(4)];

Pls= eye(4)*5;

lamda =1;   %Forgoting Factor 
SoC_CC_old=1;

for i=1:s(1)
    if I(i) > 0 
        eta = 1;
    else
        eta = 0.99;
    end
    if i ==1
            Vold =V(1);
            Iold = 0;
            SoC_CC_old=0;
            R0old =0.012;
            R1old = 0.01;
            C1old = 600;
            Voc_old=V(1);
            eold = 1;
        else
            Vold = V(i-1);
            Iold = I(i-1);
            R0old = R0(i-1);
            R1old = R1(i-1);
            C1old = C1(i-1);
            Voc_old= Voc(i-1);
            eold = e(i-1);
            SoC_CC_old  = SoC_CC(i-1);
    end
            phi = [1 Vold I(i) Iold];      % known Qantity
            Vpr(i) = phi * theta;     % Termianl Voltage Prediction
            e(i)= V(i) -  Vpr(i);           % error in prediction
            K= Pls*phi'/([phi*Pls*phi']+ lamda);     % Estimator gain  
            Pls=(1/lamda)*[eye(4)- K*phi]*Pls;              % Covariance Matri
            theta = theta + K*e(i);       % Parameter estimation updat
            
            Voc(i) = theta(1)/(1-theta(2));
%             if Voc(i) >  4.2
%                 Pls = eye(4);
%             end
%             if Voc(i) < 2
%                 Pls = 100*Pls* abs(Voc(i) - 2);
%             end
            R0(i) = (theta(4) - theta(3))/(1+ theta(2));
            R1(i) = 2*(theta(4)+ theta(2)*theta(3))/((theta(2)^2)-1);
            C1(i) = -0.25*((theta(2)+1)^2)/(theta(4)+(theta(2)*theta(3)));  
            SoC_CC(i) = SoC_CC_old - eta*Ts *I(i)/CAH;  
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

