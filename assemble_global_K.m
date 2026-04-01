function K = assemble_global_K(n_element,n_nodes,ncon,X,Y,E,t,v,analysisType)

    K = zeros(2*n_nodes);

    for i = 1:n_element

        [KE,~,~,~] = pre_processing(i,ncon,X,Y,E,t,v,analysisType);

        n1 = ncon(i,1);
        n2 = ncon(i,2);
        n3 = ncon(i,3);

        ROC(1) = (2*n1)-1;
        ROC(2) = (2*n1);
        ROC(3) = (2*n2)-1;
        ROC(4) = (2*n2);
        ROC(5) = (2*n3)-1;
        ROC(6) = (2*n3);

        for IX = 1:6
            MI = ROC(IX);
            for JX = 1:6
                MJ = ROC(JX);
                K(MI,MJ) = K(MI,MJ) + KE(IX,JX);
            end
        end
    end
end