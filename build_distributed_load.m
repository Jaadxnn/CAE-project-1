function F = build_distributed_load(X,Y,n_nodes,Fc,Ft)

    % Start with zero global load vector
    F = zeros(2*n_nodes,1);

    % ----------------------------------------
    % Find contact nodes on the top surface
    % between x = 0 and x = 0.0005
    % ----------------------------------------
    tolY = 1e-10;

    contactNodes = find( ...
        X >= 0.0000 & X <= 0.0005 & abs(Y - 0.0000) < tolY);

    disp('Contact nodes used for distributed load = ');
    disp(contactNodes);

    disp('Number of contact nodes = ');
    disp(length(contactNodes));

    % Safety check
    if isempty(contactNodes)
        error('No contact nodes found for distributed load.');
    end

    % ----------------------------------------
    % Distribute total cutting and thrust force
    % equally across contact nodes
    % ----------------------------------------
    Fx_each = Fc / length(contactNodes);
    Fy_each = Ft / length(contactNodes);

    for k = 1:length(contactNodes)
        n = contactNodes(k);

        F(2*n - 1) = F(2*n - 1) + Fx_each;   % x direction
        F(2*n)     = F(2*n)     + Fy_each;   % y direction
    end

end