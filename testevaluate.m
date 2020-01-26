function test_result = testevaluate(V,trdata, tedata)
N = size(V,1); 
for i = 1:N   
   [f1(i), f2(i)] = eval(V(i,:),trdata, tedata);
end
%test_result=[f1',f2'];
test_result=f2';



function [cardinality,acc]= eval(X,orig_data, test_data)

X = X>0.5;  %��Ⱦɫ����н���
% for i=1:size(X,2)
%     if X(i)>rand()
%         X(i)=1;
%     else
%         X(i)=0;
%     end
% end


featIxes = find(X);  %�ҳ�X�в�Ϊ0��Ԫ�����ڵ�λ�ã�����Щ���Ա�ѡ��
cardinality = numel(featIxes)/size(X,2); %���Լ��ϵĹ�ģ

 nF=size(orig_data,2);
 trX = orig_data(:,[1:(nF-1)]);   %ѵ�����ݵ�������ֵ
 trX = trX(:,featIxes); 
 trY  = orig_data(:,nF);%ѵ�����ݵ�Yֵ
 
 valX = test_data(:,[1:(nF-1)]);  
 valX = valX(:,featIxes);  %�������ݵ�������ֵ
 valY  = test_data(:,nF);  %�������ݵ�Yֵ
 
         Yhat =...
              knn(valX',trX', trY',5);     
%         Yhat =...
%             NB(valX,trX, trY);  
        accuracy = computeAccuracy(valY',Yhat);
%         
        acc=1-accuracy;
