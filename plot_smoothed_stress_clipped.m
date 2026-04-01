function plot_smoothed_stress_clipped(ncon,X,Y,Sn,titleText)

    figure;
    patch('Faces',ncon,...
          'Vertices',[X Y],...
          'FaceVertexCData',Sn,...
          'FaceColor','interp',...
          'EdgeColor','k');

    colorbar;
    axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    title(titleText);
    clim([min(Sn), max(Sn)]);
    % sLow  = prctile(Sn,5);
    % sHigh = prctile(Sn,95);
    % caxis([sLow sHigh]);
end