function accu = computeAccuracy(Y,Yhat)

    num = size(Y,2);
    rightnum = 0;
    for i = 1:num
        if Y(i) == Yhat(i)
            rightnum = rightnum + 1;
        end
    end
    
    accu = rightnum / num;