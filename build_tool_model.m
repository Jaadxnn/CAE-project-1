function model = build_tool_model()
% BUILD_TOOL_MODEL
% Creates the cutting tool finite element model.
%
% Current modelling assumptions:
% 1. 2D plane stress analysis is used.
% 2. Tool material is linear elastic with:
%    E = 210 GPa, v = 0.30
% 3. Tool thickness is taken as 0.001 m.
% 4. A graded triangular mesh is used, with strongest refinement
%    at the tool-workpiece contact corner (x = 0 to 0.0005 m).
% 5. The rear/right side of the tool is clamped.
% 6. Cutting force Fc is applied in global +x.
% 7. Thrust force Ft is applied in global -y.
% 8. The load is applied as a distributed line load over the
%    top contact region from x = 0 to 0.0005 m.

    model.E = 210e9;
    model.v = 0.30;
    model.t = 0.001;
    model.analysisType = "plane_stress";

    % ----------------------------------------
    % Get graded mesh automatically
    % ----------------------------------------
    [X,Y,ncon] = generate_graded_mesh();

    model.X = X;
    model.Y = Y;
    model.ncon = ncon;

    model.n_nodes = length(model.X);
    model.n_element = size(model.ncon,1);

    % ----------------------------------------
    % Cutting and thrust force assumptions
    % ----------------------------------------
    model.Fc = 200;     % cutting force in global +x direction
    model.Ft = -1000;    % thrust force in global -y direction

    model.F = build_contact_line_load( ...
        model.X, model.Y, model.n_nodes, model.Fc, model.Ft);

    % ----------------------------------------
    % Boundary conditions
    % Fix nodes on the rear/right side
    % ----------------------------------------
    rearNodes = find(model.X > 0.0110);

    %WRITING BOUNDARY CONDITIONS FOR SPECIFIC EDGES TO LATER BE SELECTED IN
    %THE GUI
    
    bottumNodes = find(model.X>0.00078 & model.X <0.0112 & model.Y < -.003);
    tophalfNodes= find(model.X>0.006 & model.X<0.012 & model.Y<0.000001);
    
    bottumHalfNodes = find(model.X>0.006 & model.X <0.0112 & model.Y < -.0039);

    halfNodes = find(model.X>0.006 & model.Y<0);

    dzero = [];
    %{
    for k = 1:length(rearNodes)
        n = rearNodes(k);
        dzero = [dzero; 2*n-1; 2*n];
    end
    %}
    %{
    for k = 1:length(bottumNodes)
        n = bottumNodes(k);
        dzero = [dzero; 2*n-1; 2*n];
    end
    %}
    %
    for k = 1:length(halfNodes)
        n = halfNodes(k);
        dzero = [dzero; 2*n-1; 2*n];
    end
    %}
    %{
    for k = 1:length(bottumHalfNodes)
        n = bottumHalfNodes(k);
        dzero = [dzero; 2*n-1; 2*n];
    end
    %}

    model.dzero = dzero;
    model.NDU = length(model.dzero);

end