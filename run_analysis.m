clc;
clear;
close all;

% Build model
model = build_tool_model();

disp('Force assumptions:');
disp(['Cutting force Fc = ', num2str(model.Fc), ' N (global +x)']);
disp(['Thrust force  Ft = ', num2str(model.Ft), ' N (global -y)']);

% Extract model data
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

% Apply boundary conditions
[KM,FM] = apply_boundary_conditions(K,F,NDU,dzero);

% Solve for nodal displacements
U = KM \ FM;

% Recover strains and stresses
[Ex,Ey,Gxy,Sx,Sy,Sxy] = post_processing( ...
    n_element,ncon,X,Y,E,t,v,analysisType,U);

% Average stress to nodes
Sn = nodal_stress_average(n_nodes,ncon,Sx);
Stress_Y = nodal_stress_average(n_nodes,ncon, Sy);

% Plot results
plot_smoothed_stress_clipped(ncon,X,Y,Sn,'Smoothed Stress Sx');
plot_deformed_with_stress(n_nodes,ncon,X,Y,U,Sn);
plot_smoothed_stress_clipped(ncon, X, Y, Stress_Y, 'Smoothed Stress Sy');

%Plotting von mis
Svm = sqrt(Sx.^2 - Sx.*Sy + Sy.^2 + 3*Sxy.^2);
Svm_nodes = nodal_stress_average(n_nodes,ncon, Svm);
plot_smoothed_stress_clipped(ncon, X, Y, Svm_nodes, 'Smoothed Stress Svm');


%This is plotting the nodes that are in contact with the workpiece
plot_contact_nodes(X,Y,ncon);


%Plotting nodes that are being clamped (arent experiencing any displacement)


% Print max displacement
Ux = U(1:2:end);
Uy = U(2:2:end);
Umag = sqrt(Ux.^2 + Uy.^2);

disp('Maximum displacement magnitude = ');
disp(max(Umag));