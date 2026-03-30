function [Ex,Ey,Gxy,Sx,Sy,Sxy] = post_processing( ...
    n_element,ncon,X,Y,E,t,v,analysisType,U)

    Ex  = zeros(n_element,1);
    Ey  = zeros(n_element,1);
    Gxy = zeros(n_element,1);

    Sx  = zeros(n_element,1);
    Sy  = zeros(n_element,1);
    Sxy = zeros(n_element,1);

    for i = 1:n_element

        n1 = ncon(i,1);
        n2 = ncon(i,2);
        n3 = ncon(i,3);

        [~,B,D,~] = pre_processing(i,ncon,X,Y,E,t,v,analysisType);

        d = [U(2*n1-1);
             U(2*n1);
             U(2*n2-1);
             U(2*n2);
             U(2*n3-1);
             U(2*n3)];

        e = B * d;
        Sigma = D * e;

        Ex(i)  = e(1);
        Ey(i)  = e(2);
        Gxy(i) = e(3);

        Sx(i)  = Sigma(1);
        Sy(i)  = Sigma(2);
        Sxy(i) = Sigma(3);
    end
end