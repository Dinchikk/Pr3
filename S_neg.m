function f = S_neg(t, x, alpha)
    f1 = x(2);
    f2 = -alpha -x(1)^2 - x(1)^3 - x(1)^4 - 2*x(1)*x(2);

    f = [f1; f2];
end

