clc
clear all;

M = dlmread('haberman2.txt');
data=M(:,1:3);
length_c1=0;
length_c2=0;
theclass=ones(length(M(:,1)));
for i=1:length(M(:,1))
    if M(i,4)==1
        theclass(i)=1;
        length_c1=length_c1+1;
    else
        theclass(i)=-1;
        length_c2=length_c2+1;
    end
end

tic

m=length(M(1,:))-1;

    
data=[data ones(length(M(:,1)),1)];%for bias

m=length(data(1,:));
n=length(theclass);

H=zeros(m,m);

for j=1:m-1
    H(j,j)=1;
end

f = [];
for i=1:n
A(i,:)=data(i,:).*-theclass(i);
b(i,1)=-1;%theclass(i)
end

opts = optimset('Algorithm','interior-point-convex','Display','off');
[x,fval,exitflag,output,lambda] = ...
quadprog(H,f,A,b,[],[],[],[],[],opts);

x

toc

correct=0;
test_set=data(1:303,:);
test_set_target=theclass(1:303);
    
     for i=1:length(test_set(:,1))
         if sign(test_set(i,:)*x)==test_set_target(i);
             correct=correct+1;
         end
     end
 percent=correct/length(test_set(:,1))
             