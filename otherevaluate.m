function pa=otherevaluate(v,data)
    
N = size(v,1); 
for i = 1:N   
   [f1(i), f2(i)] = evalIndividual(v(i,:),data);
end
pa= f2';



function [cardinality,acc]= evalIndividual(X,training_data)
global ami
X = X>0.5;  %��Ⱦɫ����н���
featIxes = find(X);  %�ҳ�X�в�Ϊ0��Ԫ�����ڵ�λ�ã�����Щ���Ա�ѡ��
cardinality = numel(featIxes)/size(X,2); %���Լ��ϵĹ�ģ
nof = numel(featIxes);
%cmi=sum(ami(featIxes));

if cardinality <0.2
    %cardinality = 0.99;
    acc=1000;    
else
   acc = DBindex(featIxes, training_data);
    %acc = acc - 1*cmi;
end

        
        

