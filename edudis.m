function dis = edudis(a,b)
    
    [n,m]=size(a);
    for k=1:n
        dis(k)=sqrt(sum((a(k,:)-b).^2));
    end
    