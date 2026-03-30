function plot_stress(ncon,X,Y,S,titleText)

    figure;
    patch('Faces',ncon,...
          'Vertices',[X Y],...
          'FaceVertexCData',S,...
          'FaceColor','flat',...
          'EdgeColor','k');

    colorbar;
    axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    title(titleText);
end