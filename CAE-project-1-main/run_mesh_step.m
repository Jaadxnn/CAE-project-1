clc;
clear;
close all;

[X, Y, ncon] = generate_graded_mesh();

disp('Number of nodes = ');
disp(length(X));

disp('Number of elements = ');
disp(size(ncon, 1));

plot_mesh_only(X, Y, ncon);