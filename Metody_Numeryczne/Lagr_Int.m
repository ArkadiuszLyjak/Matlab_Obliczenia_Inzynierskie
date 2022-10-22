function xv=lagrange_int(xn, yn, x)
 licznik=1 ;
 mianownik=1 ;
 sum=0 ;
 N=length(xn);
    for i=1:N
            for j=1:N
                if(j~=i)
                         mianownik=mianownik*(xn(i)-xn(j));
                         licznik=licznik*(x-xn(j));

                end
            end
    
         sum=sum+yn(i)*licznik/mianownik;
         licznik=1;
         mianownik=1;
 
    end
 xv=sum;
 end
