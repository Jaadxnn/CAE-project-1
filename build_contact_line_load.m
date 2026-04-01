function F = build_contact_line_load(X,Y,n_nodes,Fc,Ft)
% BUILD_CONTACT_LINE_LOAD
% Converts total cutting and thrust forces into equivalent nodal loads
% over the contact edge on the top surface.
%
% Load assumptions:
% - Fc acts in global +x
% - Ft acts in global -y
% - Contact region is the top edge from x = 0 to 0.0005 m
% - Total load is distributed according to tributary contact length

    % Start with zero global load vector
    F = zeros(2*n_nodes,1);

    % ----------------------------------------
    % Find contact nodes on the top surface
    % between x = 0 and x = 0.0005
    % ----------------------------------------
    tolY = 1e-10;

    contactNodes = find( ...
        X >= 0.0000 & X <= 0.0005 & abs(Y - 0.0000) < tolY);

    if isempty(contactNodes)
        error('No contact nodes found for contact line load.');
    end

    % ----------------------------------------
    % Sort contact nodes from left to right
    % ----------------------------------------
    [~,idx] = sort(X(contactNodes));
    contactNodes = contactNodes(idx);

    disp('Contact nodes used for line load = ');
    disp(contactNodes);

    disp('Number of contact nodes = ');
    disp(length(contactNodes));

    % ----------------------------------------
    % Total contact length
    % ----------------------------------------
    xContact = X(contactNodes);

    Lc = xContact(end) - xContact(1);

    if Lc <= 0
        error('Contact length is zero or negative.');
    end

    % ----------------------------------------
    % Force per unit length
    % ----------------------------------------
    qx = Fc / Lc;
    qy = Ft / Lc;

    % ----------------------------------------
    % Tributary length for each node
    % ----------------------------------------
    tributary = zeros(length(contactNodes),1);

    for i = 1:length(contactNodes)

        if i == 1
            tributary(i) = (xContact(i+1) - xContact(i)) / 2;

        elseif i == length(contactNodes)
            tributary(i) = (xContact(i) - xContact(i-1)) / 2;

        else
            tributary(i) = (xContact(i+1) - xContact(i-1)) / 2;
        end

    end

    % ----------------------------------------
    % Convert line load into nodal forces
    % ----------------------------------------
    Fx_nodes = qx * tributary;
    Fy_nodes = qy * tributary;

    % Check totals
    disp('Total Fx applied = ');
    disp(sum(Fx_nodes));

    disp('Total Fy applied = ');
    disp(sum(Fy_nodes));

    % ----------------------------------------
    % Build global load vector
    % ----------------------------------------
    for i = 1:length(contactNodes)

        n = contactNodes(i);

        F(2*n - 1) = F(2*n - 1) + Fx_nodes(i);
        F(2*n)     = F(2*n)     + Fy_nodes(i);

    end

end