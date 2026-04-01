function plot_contact_nodes(X,Y,ncon)

    tolY = 1e-10;

    contactNodes = find( ...
        X >= 0.0000 & X <= 0.0005 & abs(Y - 0.0000) < tolY);

    figure;
    triplot(ncon,X,Y,'k');
    hold on;
    plot(X(contactNodes),Y(contactNodes),'ro','MarkerFaceColor','r');

    axis equal;
    xlabel('X (m)');
    ylabel('Y (m)');
    title('Mesh with Contact Nodes');
    legend('Mesh','Contact nodes');
end