function res = reachsetdyn( alpha , t0 , t1 , N,filename )

    pause_time = 0.15;
    clear F;
    F(N) = struct('cdata',[],'colormap',[]);
   
    for i = [1:N]
        hold on
        t = t0 + i*(t1 - t0)/N;
        [X, Y, border_x, border_y] = reachset(t, 0, alpha);
        h = plot(X, Y, '-g', 'LineWidth', 2);
        plot(border_x, border_y, '-b', 'LineWidth', 2);
        axis([-8 8 -8 4]);
        ylabel('$$x_2$$','interpreter','latex','fontsize',13,'rotation',0);
        xlabel('$$x_1$$','interpreter','latex','fontsize',13);


        pause(pause_time);
        F(i) = getframe;
        hold off
    end


    vidObj = VideoWriter(filename,'uncompressed AVI');
    open(vidObj);
    writeVideo(vidObj,F);
    close(vidObj);
    
    res = 0;

end

