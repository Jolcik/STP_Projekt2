T = 0.5;
Kr = 0.3402;
Ti = 0;
Td = 0;

r2 = (Kr*Td)/T;
r1 = Kr*(T/(2*Ti) - 2*(Td/T) - 1);
r0 = Kr*(1 + T/(2*Ti) + Td/T);

kk = 200;

u = zeros(kk, 1);
y = zeros(kk, 1);
e = zeros(kk, 1);
y_zad = zeros(kk, 1);
y_zad(15:kk) = 1; 


for k = 13:kk
    y(k) = 1.66473*y(k-1) - 0.68628*y(k-2) + 0.03894*u(k-11) + 0.0343*u(k-12);
    e(k) = y_zad(k) - y(k);
    u(k) = r2*e(k-2) + r1*e(k-1) + r0*e(k) + u(k-1);
end
figure(2)

stairs(y);
hold on
plot(y_zad, ':')
%stairs(u)
hold off
xlabel('k')
ylabel('y(k)')
xlim([0 kk])
ylim([0 1.4])
legend('y(k)', 'wartość zadana')
print('STP_projekt2_zad4_pid_1','-dpng','-r400')