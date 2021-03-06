clc;
clear;
close all;

% Question 4-2

%% Create Data
x = [0 0;2 1;2 0;2 -1;1.5 .5;1.5 0;1.5 -.5;1 0;-2 1;-2 0;-2 -1;-1.5 .5;-1.5 0;-1.5 -.5;-1 0];
numberOfData = size(x,1);
%[center,U,obj_fcn] = fcm(x,4);
plot(x(:,1),x(:,2),'.')
hold on

%% Center Initialization
numberOfCenter = 2;
center = zeros(2,2);
Colors=hsv(numberOfCenter);

for c=1:numberOfCenter
    center(c,:) = x(c,:);
    plot(center(c,1),center(c,2),'ks','MarkerSize',12,'MarkerFaceColor',Colors(c,:))
end
legend('Data','Center A','Center B');

%% Membership Function Initialization
m = 2;
U = rand(numberOfData,numberOfCenter);
ep = .00001;
% normalization
for i=1: numberOfData
    U(i,:) = U(i,:)./sum(U(i,:));
end

%% FCM Algorithm
epsilon = .01;
eps_vec = ones(1,numberOfCenter);
eps = 1;

while eps >= epsilon
    
    % Update Membership function
    for i=1: numberOfData
        ui = U(i,:);
        d1i = norm(center(1,:) - x(i,:),2)+ep;
        d2i = norm(center(2,:) - x(i,:),2)+ep;
        
        U(i,1) = 1/((d1i/d1i)^(2/(m - 1)) + (d1i/d2i)^(2/(m - 1)));
        U(i,2) = 1/((d2i/d1i)^(2/(m - 1)) + (d2i/d2i)^(2/(m - 1)));
    end
    for i=1: numberOfData
        U(i,:) = U(i,:)./sum(U(i,:));
    end
    
    % Update centers
    for c=1:numberOfCenter
        xy_sum = 0;
        um_sum = 0;
        for n=1: numberOfData
            xy_sum = xy_sum + (U(n,c)^m) * x(n,:);
            um_sum = um_sum + U(n,c)^m;
        end
        new_center_i = xy_sum/um_sum;
        eps_vec(c) = norm(center(c,:) - new_center_i,2);
        center(c,:) = new_center_i;
    end
    
    % Update Epsilon
    eps = max(eps_vec);
    hold off
    plot(x(:,1),x(:,2),'.')
    hold on
    for c=1:numberOfCenter
        plot(center(c,1),center(c,2),'ks','MarkerSize',12,'MarkerFaceColor',Colors(c,:))
    end
    pause(0.1);
end