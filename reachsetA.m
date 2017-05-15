function [X1, X2, SLX, SLY] = reachsetA(alpha, T, tr_flag)
    X1 = []; X2 = []; SLX = []; SLY = [];
    options = odeset('Events', @event1);
    [t, X, TE, YE, IE] = ode45(@(t,x)S_pos(t,x,alpha), [0,T], [0 0.0011 0], options); 
    TSL = t;
    TSL(end) = [];
    SLX = fliplr(X(:,1)');
    SLY = fliplr(X(:,2)');
    options = odeset('Events', @event2);
    [t, X, TE, YE, IE] = ode45(@(t,x)S_neg(t,x,alpha), [0,T], [0 0.0011 0], options);
    SLX = [SLX X(:,1)'];
    SLY = [SLY X(:,2)'];

end

