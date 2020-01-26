function DB = DBindex(featureID, data)


[n,m]=size(data);
 
R = data(:,[featureID,m]);

[n,m]=size(R);
a=unique(R(:,m));
num=length(a);  

for i=1:num 
     eval(['C',num2str(i),'= R((find(R(:,m)==a(i))),[1:(m-1)])',';'])     
end
v=[];
radius=[];
for i=1:num 
    temp=[];
    eval(['temp =', 'C',num2str(i),';']);    
    v(i,:)=mean(temp); %求出每个类的中心    
    ddd = edudis(temp,v(i,:));
    S(i)= mean(ddd);    %求出各个类的半径 
end

for i=1:num   %求出各个类中心之间的距离
    for j=1:num
        d(i,j) = edudis(v(i,:),v(j,:));
    end
end
temp=[];
for i=1:num
    for j=1:num
        if i==j
            R(i,j)=0;
        else
            R(i,j)=(S(i)+S(j))/d(i,j);
        end
    end
    temp(i)=max(R(i,:));
end

DB = mean(temp);
