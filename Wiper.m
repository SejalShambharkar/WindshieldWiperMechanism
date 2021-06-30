clc
clear all
close all
%Wiper Mechanism Visualization with 
% Matlab Arbitrarily set 
% rocking angle to pi/3 After arbitrarily setting the length of 
% L4 and L1, the length of the remaining L2 and L3 is obtained using the formula.To obtain % L2, write the formula rocking angle = 2*asin(L2/L4To obtain % L3, use the formula L1^2 + L2^2 = 3L^2 + L4^2.

l1=150;
l2=30;
l4=80; % Grashof equation established & non qrr established
l3= sqrt(l1*l1 + l2*l2 - l4*l4); 
l5=300; %450/(cos(pi/3));


th4star = 2*asin(l2/l4); %Angle at which l4 locks
th4star_degree = th4star*180/pi;

th2 = 0 : 5*pi/180 : 2*pi*5;

th4p=nan(size(th2)); % theta4 for plus
th4m=nan(size(th2)); % theta4 for minus

for j=1:length(th2)
  % Save Theta 4 when Theta 2 is Given
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=(l1^2+l2^2-l3^2+l4^2)/(2*l2*l4)+l1/l4*cos(th2(j));
    %th4p(j)=2*atan((a+(a^2+b^2-c^2)^0.5)/(b+c)); % The value of the positive among the formulas of the root
    th4m(j)=2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c)); % The value of the positive among the formulas of the root
end




th5p=nan(size(th2)); % theta5 for plus
th5m=nan(size(th2)); % theta5 for minus

for j=1:length(th2)
  % Save Theta 5 when Theta 2 is Given
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=(l1^2+l2^2-l3^2+l4^2)/(2*l2*l4)+l1/l4*cos(th2(j));
    %th5p(j)=pi+2*atan((a+(a^2+b^2-c^2)^0.5)/(b+c)) ; % The value of the positive among the formulas of the root
    th5m(j)=pi+2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c)) ; % The value of the positive among the formulas of the root
end




th3p=nan(size(th2)); % theta4 for plus
th3m=nan(size(th2)); % theta4 for minus

for j=1:length(th2)
   % Get Theta 3 when Theta 2 is Given
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=-( (l1^2+l2^2+l3^2-l4^2)/(2*l2*l3)+l1/l3*cos(th2(j)) );
    %th3p(j)=2*atan((a+(a^2+b^2-c^2)^0.5)/(b+c)); % The value of the positive among the formulas of the root
    th3m(j)=2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c)); % The value of the positive among the formulas of the root
end

%% Plot configurations for plus sign




startwipe_degree= (min(th5m))*180/pi;
endwipe_degree= (max(th5m))*180/pi;
% The wiping range (based on the wiper center point)should be designed to be 450 mm left and right by giving an angle difference between % L4 and L5.
% 60 degrees should be wiped from the center, so the start should be 60 degrees and the end should be 120 degrees.
% th5 subtracts as much as 60-startwipe_degree to give an angle difference between L4 and L5.
startwipe_radian = min(th5m);
delth5 = (pi/3)-startwipe_radian;

for j=1:length(th2)
%Get Theta 5 when  Theta 2 is Given   
    a=sin(th2(j)); 
    b=l1/l2+cos(th2(j));
    c=(l1^2+l2^2-l3^2+l4^2)/(2*l2*l4)+l1/l4*cos(th2(j));
    %th5p(j)=pi+2*atan((a+(a^2+b^2-c^2)^0.5)/(b+c))+delth5 ;
    th5m(j)=pi+2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c))+delth5 ;  
end


fprintf('Length of L1: %1.f mm\n',l1)
fprintf('Length of L2: %1.f mm\n',l2)
fprintf('Length of L3: %f mm\n',l3)
fprintf('Length of L4: %1.f mm\n',l4)
fprintf('Angle between L4 and L5: %f(degree)\n',-delth5*180/pi) 
for j= 1: length(th2)
    %hold on;
    O2x=0;
    O2y=-50;
    Ax=O2x+l2*cos(th2(j));
    Ay=O2y+l2*sin(th2(j));
    Bx=Ax+l3*cos(th3m(j));
    By=Ay+l3*sin(th3m(j));
  %  Bx2=-l1+l4*cos(th4p(j));
  %  By2=l4*sin(th4p(j));
    O4x=-l1;
    O4y=0;
    Cx= O4x+l5*cos(th5m(j));
    Cy= O4y+l5*sin(th5m(j));
    Dx= -200+O4x+l5*cos(th5m(j));
    Dy= O4y+l5*sin(th5m(j));
    O5x= -200+O4x;
    O5y= 0;
    W1x = Cx;
    W1y = Cy+100;
    W2x = Cx;
    W2y = Cy-100;
    
   
    
    xtemp=[O2x Ax Bx  O4x Cx Dx O5x];
    ytemp=[O2y Ay By  O4y Cy Dy O5y];
    wx = [W1x W2x];
    wy = [W1y W2y];
    plot(xtemp,ytemp,'bo-',wx,wy,'ro-','linewidth',2);
    title('Wiper-Mechanical Design ')
    grid on
    xlabel('X [cm]')
    ylabel('Y [cm]')

    ylim([-500,500])
    axis equal;
        hold off
    pause(0.0000001)
 
end
