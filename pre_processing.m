function [KE,B,D,A] = pre_processing(i,ncon,X,Y,E,t,v,analysisType)
% Computes elemental stiffness matrix for one triangular element

    n1 = ncon(i,1);
    n2 = ncon(i,2);
    n3 = ncon(i,3);

    x1 = X(n1);   x2 = X(n2);   x3 = X(n3);
    y1 = Y(n1);   y2 = Y(n2);   y3 = Y(n3);

    A = 0.5 * det([1 x1 y1;
                   1 x2 y2;
                   1 x3 y3]);

    if A <= 0
        error('Element %d has non-positive area. Check node ordering.', i);
    end

    b1 = y2 - y3;
    b2 = y3 - y1;
    b3 = y1 - y2;

    c1 = x3 - x2;
    c2 = x1 - x3;
    c3 = x2 - x1;

    B = (1/(2*A)) * [b1 0  b2 0  b3 0;
                     0  c1 0  c2 0  c3;
                     c1 b1 c2 b2 c3 b3];

    switch analysisType
        case "plane_stress"
            D = (E/(1-v^2)) * [1 v 0;
                               v 1 0;
                               0 0 (1-v)/2];
        case "plane_strain"
            D = (E/((1+v)*(1-2*v))) * [1-v v 0;
                                       v 1-v 0;
                                       0 0 (1-2*v)/2];
        otherwise
            error('analysisType must be "plane_stress" or "plane_strain".');
    end

    KE = t * A * (B.') * D * B;
end