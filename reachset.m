function [X1_1, X2_1, border_x, border_y] = reachset(tau, tr_flag, alpha)
    
    refine = 7;
    rel_tol = 0.00001;
    abs_tol = 0.00001;
    X1 = [];
    X2 = [];
    fl_pos = 0;
    T = tau;    
    
    
    options = odeset('Events', @event1, 'Refine', refine);
    [t, X, TE, YE, IE] = ode45(@(t, x)S_pos(t, x, alpha), [0, T], [0, 0.0011], options);
    times_pos = t;
    
    if (size(TE, 1) ~= 0)
        t_pos = TE;
    else
        t_pos = T;
        times_pos(end) = [];
        x1_end_pos = X(end, 1);
        x2_end_pos = X(end, 2);
        fl_pos = 1;
    end
    
    border_x = X(:, 1);
    border_x = border_x(end:-1:1);
    border_y = X(:, 2);
    border_y = border_y(end:-1:1);
    
    n = size(times_pos, 1);
    x1_pos = X(:, 1);
    x2_pos = X(:, 2);
    options = odeset('Events', @event2, 'RelTol', rel_tol, 'AbsTol', abs_tol);
    
    for i=1:n
        t_next = times_pos(i);
        while(t_next < T)
            [t, X, TE, YE, IE] = ode45(@(t, x)S_neg_psi(t, x, alpha), [t_next, T],...
                [x1_pos(i), x2_pos(i), 1, -0.01], options);
            if(tr_flag == 1)
                plot(X(:, 1), X(:, 2), '-y');    
            end
            if (size(TE, 1) ~= 0)
                t_next = TE;
            else
                t_next = T;
                X1 = [X1, X(end, 1)];
                X2 = [X2, X(end, 2)];
            end
            if (t_next ~= T)
                [t, X, TE, YE, IE] = ode45(@(t, x)S_pos_psi(t, x, alpha), [t_next, T],...
                    [x1_pos(i), x2_pos(i), -1, 0.01], options);
                if (tr_flag == 1)
                    plot(X(:, 1), X(:, 2), '-y');
                end
                if (size(TE, 1) ~= 0)
                    t_next = TE;
                else
                    t_next = T;
                    X1 = [X1, X(end, 1)];
                    X2 = [X2, X(end, 2)];
                end
            end
            
        end
        
    end
    
    if (fl_pos == 1)
        X1 = [X1, x1_end_pos];
        X2 = [X2, x2_end_pos];
    end
    
    options = odeset('Events', @event1, 'Refine', refine);
    [t, X, TE, YE, IE] = ode45(@(t, x)S_neg(t, x, alpha), [0, T], [0, -0.01], options);
    times_neg = t;
    
    if (size(TE, 1) ~= 0)
        t_neg = TE;
    else
        t_neg = T;
        times_neg(end) = [];
        x1_end_neg = X(end, 1);
        x2_end_neg = X(end, 2);
    end

    border_x = cat(1, border_x, X(:, 1));
    border_y = cat(1, border_y, X(:, 2));
    n = size(times_neg, 1);
    x1_neg = X(:, 1);
    x2_neg = X(:, 2);
    options = odeset('Events', @event2, 'RelTol', rel_tol, 'AbsTol', abs_tol);
    
    
    for i=1:n
        t_next = times_neg(i);
        while(t_next < T)
            [t, X, TE, YE, IE] = ode45(@(t, x)S_pos_psi(t, x, alpha), [t_next, T],...
                [x1_neg(i), x2_neg(i), -1, 0.01], options);
            
            if (tr_flag == 1)
                plot(X(:, 1), X(:, 2), '-y');
            end
            
            if (size(TE, 1) ~= 0)
                t_next = TE;
            else
                t_next = T;
                X1 = [X1, X(end, 1)];
                X2 = [X2, X(end, 2)];
            end
            
            if (t_next ~= T)
                
                [t, X, TE, YE, IE] = ode45(@(t, x)S_neg_psi(t, x, alpha), [t_next, T],...
                    [x1_neg(i), x2_neg(i), 1, 0.01], options);
                
                if (tr_flag == 1)
                    plot(X(:, 1), X(:, 2), '-y');
                end
                
                if (size(TE, 1) ~= 0)
                    t_next = TE;
                else
                    t_next = T;
                    X1 = [X1, X(end, 1)];
                    X2 = [X2, X(end, 2)];
                end
                
            end
            
        end
    end
    X1 = [X1, x1_end_neg, X1(1)];
    X2 = [X2, x2_end_neg, X2(1)];
    X1_1 = [];
    X2_1 = [];
    
    for(i = [1 :max(size(X1))])
        if ( (abs(X1(i)) < 10^5) && (abs(X2(i)) < 10^5)  )
            X1_1 =[X1_1 , X1(i)];
            X2_1 =[X2_1 , X2(i)];    
        end
    end
    
    
end

