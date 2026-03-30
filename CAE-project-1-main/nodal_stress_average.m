function Sn = nodal_stress_average(n_nodes,ncon,S)

    Sn = zeros(n_nodes,1);
    count = zeros(n_nodes,1);

    for i = 1:size(ncon,1)
        for j = 1:3
            node = ncon(i,j);
            Sn(node) = Sn(node) + S(i);
            count(node) = count(node) + 1;
        end
    end

    Sn = Sn ./ count;
end