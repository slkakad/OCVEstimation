clc;
clear all;
close all;

R0(1) = 1e-3;
R1(1) = 1e-3;
C1(1) = 500;
Voc(1) = 4.2;

den = (1 + 2*R1(1)*C1(1))
theta(2) = -((1 - (2*R1(1)*C1(1)))/den);
theta(1) = (1-theta(2))*Voc(1);
theta(3) = -((R0(1) +R1(1) + 2*R1(1)*C1(1)*R0(1))/den);
theta(4) = -((R0(1) +R1(1)- 2*R1(1)*C1(1)*R0(1))/den);
theta =[theta(1),theta(2),theta(3),theta(4)]

Voc(1) = theta(1)/(1-theta(2))
R0(1)  = (theta(4) - theta(3))/(1+ theta(2))
R1(1)  = 2*(theta(4)+ theta(2)*theta(3))/((theta(2)^2)-1)
C1(1) = -0.25*((theta(2)+1)^2)/(theta(4)+(theta(2)*theta(3))) 