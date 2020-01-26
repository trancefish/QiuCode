function pa=Evaluate(v,data)
    
N = size(v,1); 
for i = 1:N   
   [f1(i), f2(i)] = evalIndividual(v(i,:),data);
end

%pa=[f1',f2'];
pa= f2';



function [cardinality,acc]= evalIndividual(X,training_data)

X = X>0.5;  %对染色体进行解码
% for i=1:size(X,2)
%     if X(i)>rand()
%         X(i)=1;
%     else
%         X(i)=0;
%     end
% end



featIxes = find(X);  %找出X中不为0的元素所在的位置，即这些属性被选中
cardinality = numel(featIxes)/size(X,2); %属性集合的规模


if cardinality == 0
    cardinality = 0.99;
    acc=1;
    
else
    acc=trainAndValidateknn(featIxes, training_data);
    acc=1-acc+0.1*cardinality;
end

        
        

