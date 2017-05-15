%%
t = 1.4;
alpha = 0.8;
t0 = 0.2;
t1 = 1.95;
N = 17;
%%

hold on;
[X, Y, border_x, border_y] = reachset(t, 0, alpha);
h = plot(X, Y, '-g', 'LineWidth', 2);
plot(border_x, border_y, '-b', 'LineWidth', 2);
axis([-8 8 -8 4]);
ylabel('$$x_2$$','interpreter','latex','fontsize',13,'rotation',0);
xlabel('$$x_1$$','interpreter','latex','fontsize',13);


%%
reachsetdyn(alpha , t0 , t1 , N , 'result');

