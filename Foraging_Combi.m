function qnew=Foraging_Combi(q,sz)
    sz=ceil(sz);
    m=randi([1 4]);
    
    switch m
        case 1
            % Do Swap
            qnew=Swap(q,sz);
            
        case 2
            % Do Reversion
            qnew=Reversion(q,sz);

        case 3
            % Do Insertion
            qnew=Insertion(q,sz);

        case 4
            % Do Reversion
            qnew=Reversion(q,sz);
    end

end

function qnew=Swap(q,sz)

    n=numel(q);
    i1=randi([1 n]);
    i2=i1 + randi([1 sz]);
    i2(i2>n)=n;
    qnew=q;
    qnew([i1 i2])=q([i2 i1]);
    
end

function qnew=Reversion(q,sz)

    n=numel(q);
    
    i1=randi([1 n]);
    i2=i1 + randi([1 sz]);
    i2(i2>n)=n;
    
    qnew=q;
    qnew(i1:i2)=q(i2:-1:i1);

end

function qnew=Insertion(q,sz)

    n=numel(q);
    a=randi(2);
    switch a
        case 1
            i1=randi([1 n]);
        case 2
            i1=randi([1 n-1]);
            i1=[i1 i1+1];
    end
    i2=i1(end) + randi([-sz sz]);
    i2(i2>n)=n;
    i2(i2<1)=1;
    
    
    if i1<i2
        qnew=[q(1:i1-1) q(i1+1:i2) q([i1]) q(i2+1:end)];
    else
        qnew=[q(1:i2) q([i1]) q(i2+1:i1-1) q(i1+1:end)];
    end

end

