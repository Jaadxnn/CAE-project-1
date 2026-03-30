function model = build_tool_model_step1()

    model.E = 210e9;
    model.v = 0.30;
    model.t = 0.001;
    model.analysisType = "plane_stress";

    % -----------------------------
    % Node coordinates
    % -----------------------------
    model.X = [
        0.00000;   % 1
        0.00050;   % 2
        0.00600;   % 3
        0.01200;   % 4
        0.00039;   % 5
        0.00325;   % 6
        0.00860;   % 7
        0.01160;   % 8
        0.00078;   % 9
        0.00600;   % 10
        0.01120    % 11
    ];

    model.Y = [
         0.00000;   % 1
         0.00000;   % 2
         0.00000;   % 3
         0.00000;   % 4
        -0.00200;   % 5
        -0.00200;   % 6
        -0.00200;   % 7
        -0.00200;   % 8
        -0.00400;   % 9
        -0.00400;   % 10
        -0.00400    % 11
    ];

    model.n_nodes = length(model.X);

    % -----------------------------
    % Triangular connectivity
    % Counterclockwise ordering
    % -----------------------------
    model.ncon = [
        1 5 2;
        2 5 6;
        2 6 3;
        3 6 7;
        3 7 4;
        4 7 8;
        5 9 6;
        6 9 10;
        6 10 7;
        7 10 11;
        7 11 8
    ];

    model.n_element = size(model.ncon,1);

    % -----------------------------
    % Load vector
    % -----------------------------
    model.F = zeros(2*model.n_nodes,1);

    Fc = 200;      % N
    Ft = -100;     % N

    % still using simple test load near cutting side
    model.F(3) = Fc;
    model.F(4) = Ft;

    % -----------------------------
    % Fixed DOFs
    % Clamp rear side of tool
    % Here: fix nodes 4, 8, 11
    % -----------------------------
    model.dzero = [7 8 15 16 21 22]';
    model.NDU = length(model.dzero);

end