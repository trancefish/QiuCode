function test_result = testevaluate(V,trdata, tedata)
N = size(V,1); 
for i = 1:N   
   [f1(i), f2(i)] = eval(V(i,:),trdata, tedata);
end
%test_result=[f1',f2'];
test_result=f2';



function [cardinality,acc]= eval(X,orig_data, test_data)

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

 nF=size(orig_data,2);
 trX = orig_data(:,[1:(nF-1)]);   %训练数据的属性项值
 trX = trX(:,featIxes); 
 trY  = orig_data(:,nF);%训练数据的Y值
 
 valX = test_data(:,[1:(nF-1)]);  
 valX = valX(:,featIxes);  %测试数据的属性项值
 valY  = test_data(:,nF);  %测试数据的Y值
 
         Yhat =...
              knn(valX',trX', trY',5);     
%         Yhat =...
%             NB(valX,trX, trY);  
        accuracy = computeAccuracy(valY',Yhat);
%         
        acc=1-accuracy;
