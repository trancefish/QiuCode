function pa=otherevaluate(v,data)
    
N = size(v,1); 
for i = 1:N   
   [f1(i), f2(i)] = evalIndividual(v(i,:),data);
end
pa= f2';



function [cardinality,acc]= evalIndividual(X,training_data)
global ami
X = X>0.5;  %对染色体进行解码
featIxes = find(X);  %找出X中不为0的元素所在的位置，即这些属性被选中
cardinality = numel(featIxes)/size(X,2); %属性集合的规模
nof = numel(featIxes);
%cmi=sum(ami(featIxes));

if cardinality <0.2
    %cardinality = 0.99;
    acc=1000;    
else
   acc = DBindex(featIxes, training_data);
    %acc = acc - 1*cmi;
end

        
        

