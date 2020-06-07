T = 0.5;
Kr = 0.3402;
Ti = 10;
Td = 2.4;

r2 = (Kr*Td)/T;
r1 = Kr*(T/(2*Ti) - 2*(Td/T) - 1);
r0 = Kr*(1 + T/(2*Ti) + Td/T);

kk = 400;

wsp_K = 1.286;

K0_nom = 3.4;
K0 = wsp_K*K0_nom;
T0_nom = 5;
T0 = 2.0*T0_nom;
T1 = 1.75;
T2 = 5.51;
H = tf([K0], [T1*T2 T1+T2 1], 'InputDelay', T0);
Hd = c2d(H, T);
[b, a] = tfdata(Hd, 'v');

dodatkowe_opoznienie = (T0 - T0_nom)/T;

u = zeros(kk, 1);
y = zeros(kk, 1);
e = zeros(kk, 1);
y_zad = zeros(kk, 1);
y_zad(15 + dodatkowe_opoznienie:kk) = 1; 

x = dodatkowe_opoznienie;

for k = 13 + x:kk
    y(k) = -a(2)*y(k-1) -a(3)*y(k-2) + b(2)*u(k-11-x) + b(3)*u(k-12-x);
    e(k) = y_zad(k) - y(k);
    u(k) = r2*e(k-2) + r1*e(k-1) + r0*e(k) + u(k-1);
end

stairs(y)

xlabel('k')
ylabel('y(k)')
xlim([0 kk])
ylim([0 2.2])
tytul = sprintf('Regulacja PID dla K0/K0nom = %0.3f', wsp_K);
title(tytul)
nazwa_pliku = sprintf('STP_projekt2_zad6_pid_%0.3f.png', wsp_K);
%print(nazwa_pliku, '-dpng','-r400')