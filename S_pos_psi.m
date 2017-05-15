function f = S_pos_psi(t, x, alpha)
    f1 = x(2);
    f2 = alpha -x(1)^2 - x(1)^3 - x(1)^4 - 2*x(1)*x(2);
    f3 = x(4)*(2*x(1) + 3*x(1)^2 + 4*x(1)^3 + 2*x(2));
    f4 = -x(3) + 2*x(4)*x(1);

    f = [f1; f2; f3; f4];
end

