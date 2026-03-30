function plot_mesh_only(X,Y,ncon)

    figure;
    triplot(ncon,X,Y,'k');
    axis equal;
    grid on;
    xlabel('X (m)');
    ylabel('Y (m)');
    title('Graded Triangular Mesh');

end