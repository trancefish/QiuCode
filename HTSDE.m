clc
clear all
close all



data=xlsread('D:\data\leukemia-other.xlsx');


data1 = data(:,[1:(size(data,2)-1)]);  
data2 = data(:,size(data,2));
 data1 = (premnmx(data1'))';
 data = [data1,data2];
 split = 0.7;  %
 totalnum = size(data,1); 
 trnum = floor(totalnum * split);
 
 orig_data = data([1:trnum],:);
 test_data = data([(trnum+1):totalnum],:);
 nVar = size(orig_data,2)-1;
 featurenum=nVar+1;
 

     
m=nVar; 
n=20; 
maxite=50;
maxrun= 20;

LB=0; %lower bounds of variables
UB=1; %upper bounds of variables

F=1;
b=[];
tic
for run = 1:maxrun
run

for i=1:n
for j=1:m
x(i,j)=LB+rand()*(UB-LB);
end
end

f=otherevaluate(x,orig_data);
[fmin0,index0]=min(f); 
gbest=x(index0,:);

ite=1; 
CR=0.9;
while ite<=25    

for i =1:n
    a = randperm(n);
    idx = find(a==i);
    a(idx)=[];
    r = a([1,2,3]);     
    for j=1:m
       vm(i,j) = x(r(1),j) + F*(x(r(2),j) - x(r(3),j)); 
    end 
end

for i=1:n
    for j=1:m
         if vm(i,j)<LB
            vm(i,j)=LB;
         elseif vm(i,j)>UB
            vm(i,j)=UB;
         end    
    end
end

for i=1:n
    jrand = randint(1,1,[1,m]);
    for j=1:m
        if rand()<CR || j==jrand
            u(i,j) = vm(i,j);
        else
            u(i,j) = x(i,j);
        end
    end
end

fn=otherevaluate(u,orig_data);

for i=1:n    
    if fn(i)<f(i)
        x(i,:) = u(i,:);  
        f(i) = fn(i);
    end
end

[fmin,index]=min(f);

if fmin<fmin0
    gbest=x(index,:);   
    fmin0=fmin;  
end

ite=ite+1;
end

%！！！！！the second stage！！！！！！！！！

f=Evaluate(x,orig_data);%evaluate with the classification accuracy
[fmin0,index0]=min(f);  
gbest=x(index0,:);

CR=0.1;
while ite<=50    

for i =1:n
    a = randperm(n);
    idx = find(a==i);
    a(idx)=[];
    r = a([1,2,3]);     
    for j=1:m
        vm(i,j) = gbest(1,j)+ F*(x(r(2),j) - x(r(3),j));
    end
end

for i=1:n
    for j=1:m
         if vm(i,j)<LB
            vm(i,j)=LB;
         elseif vm(i,j)>UB
            vm(i,j)=UB;
         end    
    end
end


for i=1:n
    jrand = randint(1,1,[1,m]);
    for j=1:m
        if rand()<CR || j==jrand
            u(i,j) = vm(i,j);
        else
            u(i,j) = x(i,j);
        end
    end
end

fn=Evaluate(u,orig_data);

for i=1:n    
    if fn(i)<f(i)
        x(i,:) = u(i,:);  
        f(i)=fn(i);
    end
end

[fmin,index]=min(f);

if fmin<fmin0
    gbest=x(index,:);   
    fmin0=fmin;  
end

ite=ite+1;
end

acc = 1 - testevaluate(gbest,orig_data, test_data);
nof=sum(gbest>0.5);
a=[acc*100,nof,fmin0];
b=[b;a];
t=toc;

end

