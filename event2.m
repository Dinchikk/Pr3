function [value, isterminal, direction] = event2(t, x)
    ep = 0.001;
    value = 0;
    if (abs(x(4)) < ep)
        value = 1;
    end;
    isterminal = 1;
    direction = 0;
end

