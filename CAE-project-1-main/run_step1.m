clc;
clear;

% Build model data
model = build_tool_model_step1();

% Pull fields out of the struct
n_element = model.n_element;
n_nodes   = model.n_nodes;
ncon      = model.ncon;
X         = model.X;
Y         = model.Y;
E         = model.E;
v         = model.v;
t         = model.t;
F         = model.F;
NDU       = model.NDU;
dzero     = model.dzero;
analysisType = model.analysisType;

clc;
clear;

% Build model data
model = build_tool_model_step1();

% Show original force vector
disp('Original load vector F = ');
disp(model.F);

% Pull fields out of the struct
n_element = model.n_element;
n_nodes   = model.n_nodes;
ncon      = model.ncon;
X         = model.X;
Y         = model.Y;
E         = model.E;
v         = model.v;
t         = model.t;
F         = model.F;
NDU       = model.NDU;
dzero     = model.dzero;
analysisType = model.analysisType;

% Assemble global stiffness matrix
K = assemble_global_K(n_element,n_nodes,ncon,X,Y,E,t,v,analysisType);

disp('Global stiffness matrix K = ');
disp(K);

% Apply boundary conditions
[KM,FM] = apply_boundary_conditions(K,F,NDU,dzero);

disp('Modified load vector FM = ');
disp(FM);

% Solve for nodal displacements
U = KM \ FM;

disp('Nodal displacement vector U = ');
disp(U);

[Ex,Ey,Gxy,Sx,Sy,Sxy] = post_processing( ...
    n_element,ncon,X,Y,E,t,v,analysisType,U);

disp('Element strain Ex = ');
disp(Ex);

disp('Element strain Ey = ');
disp(Ey);

disp('Element strain Gxy = ');
disp(Gxy);

disp('Element stress Sx = ');
disp(Sx);

disp('Element stress Sy = ');
disp(Sy);

disp('Element stress Sxy = ');
disp(Sxy);

scale = 20; % adjust visually

Xd = X + scale*U(1:2:end);
Yd = Y + scale*U(2:2:end);

Sn = nodal_stress_average(n_nodes,ncon,Sx);

plot_smoothed_stress_clipped(ncon,X,Y,Sn,'Smoothed Stress Sx');
plot_deformed_with_stress(n_nodes,ncon,X,Y,U,Sn);

Ux = U(1:2:end);
Uy = U(2:2:end);
Umag = sqrt(Ux.^2 + Uy.^2);

disp('Maximum displacement magnitude = ');
disp(max(Umag));