function [KM,FM] = apply_boundary_conditions(K,F,NDU,dzero)

    KM = K;
    FM = F;

    for k = 1:NDU
        n = dzero(k);
        KM(n,:) = 0;
    end

    for k = 1:NDU
        n = dzero(k);
        KM(:,n) = 0;
    end

    for k = 1:NDU
        n = dzero(k);
        KM(n,n) = 1;
        FM(n) = 0;
    end
end