function [value, isterminal, direction] = event1(t, x)
    ep = 0.001;
    value = 0;
    if (abs(x(2)) < ep)
        value = 1;
    end;
    isterminal = 1;
    direction = 0;
end

