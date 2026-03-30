function model = build_tool_model_step1()

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
    % Distributed load over contact region
    % ----------------------------------------
    Fc = 200;      % total cutting force (N)
    Ft = -100;     % total thrust force (N)

    model.F = build_distributed_load(model.X,model.Y,model.n_nodes,Fc,Ft);

    % ----------------------------------------
    % Boundary conditions
    % Fix nodes on the rear/right side
    % ----------------------------------------
    rearNodes = find(model.X > 0.0110);

    dzero = [];
    for k = 1:length(rearNodes)
        n = rearNodes(k);
        dzero = [dzero; 2*n-1; 2*n];
    end

    model.dzero = dzero;
    model.NDU = length(model.dzero);

end