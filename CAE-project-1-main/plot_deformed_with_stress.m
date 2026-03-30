function plot_deformed_with_stress(n_nodes,ncon,X,Y,U,Sn)

    Ux = U(1:2:end);
    Uy = U(2:2:end);

    Umag = sqrt(Ux.^2 + Uy.^2);
    maxU = max(Umag);

    toolLength = max(X) - min(X);

    scaleFactor = 0.08 * toolLength / maxU;

    Xd = X + scaleFactor * Ux;
    Yd = Y + scaleFactor * Uy;

    figure;
    patch('Faces',ncon,...
          'Vertices',[Xd Yd],...
          'FaceVertexCData',Sn,...
          'FaceColor','interp',...
          'EdgeColor','k');

    colorbar;
    axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    title('Deformed Shape with Stress');

    sLow  = prctile(Sn,5);
    sHigh = prctile(Sn,95);
    caxis([sLow sHigh]);
end