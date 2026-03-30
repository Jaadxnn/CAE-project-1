function plot_deformed_shape(ncon,X,Y,U,scaleFactor)

    Ux = U(1:2:end);
    Uy = U(2:2:end);

    Xd = X + scaleFactor * Ux;
    Yd = Y + scaleFactor * Uy;

    figure;
    triplot(ncon,X,Y,'k--');
    hold on;
    triplot(ncon,Xd,Yd,'b-');
    axis equal;
    grid on;
    xlabel('X (m)');
    ylabel('Y (m)');
    title('Undeformed and Deformed Shape');
    legend('Undeformed','Deformed');
end