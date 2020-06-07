sys_dyskretny = tf([0.03894 0.0343], [1 -1.66473 0.68628], 0.5, 'InputDelay', 10);
s = step(sys_dyskretny, 100);

Dn = 1;

N = 17;
Nu = 2;
D = 80;
lambda = 2;

Mp = zeros(N, D-1);
for i = 1:N
    for j = 1:D-1
        if i + j < D
            Mp(i, j) = s(i + j) - s(j);
        else
            Mp(i, j) = s(D) - s(j);
        end
    end
end

M = zeros(N, Nu);
for i = 1:N
    for j = 1:i
        if j <= Nu
            M(i, j) = s(i - j + 1);
        end
    end
end

I = eye(Nu);
K = (((M')*M + lambda*I)^(-1))*(M');
ku = K(1, :)*Mp;
ke = sum(K(1, :));

%%%%%%%

wsp_K = 0.769;

K0_nom = 3.4;
K0 = wsp_K*K0_nom;
T0_nom = 5;
T0 = 2*T0_nom;
T1 = 1.75;
T2 = 5.51;
T = 0.5;
H = tf([K0], [T1*T2 T1+T2 1], 'InputDelay', T0);
Hd = c2d(H, T);
[b, a] = tfdata(Hd, 'v');

kk = 1000;

dodatkowe_opoznienie = (T0 - T0_nom)/T;

u = zeros(kk, 1);
d_upk = zeros(1, D-1);
y = zeros(kk, 1);
y_zad = zeros(kk, 1);
y_zad(15 + dodatkowe_opoznienie:kk) = 1; 
e = zeros(kk, 1);

x = dodatkowe_opoznienie;

for k = 13 + x:kk
    y(k) = -a(2)*y(k-1) -a(3)*y(k-2) + b(2)*u(k-11-x) + b(3)*u(k-12-x);
    e(k) = y_zad(k)-y(k);
    
    d_upk(2:D-1) = d_upk(1:D-2);
    d_uk = ke*e(k) - ku*d_upk';
    d_upk(1) = d_uk;
    u(k) = u(k-1) + d_uk;
end
stairs(y)

xlabel('k')
ylabel('y(k)')
xlim([0 kk])
ylim([0 2.5])
tytul = sprintf('Regulacja DMC dla K0/K0nom = %0.3f i T0/T0nom = 1.6', wsp_K);
title(tytul)
nazwa_pliku = sprintf('STP_projekt2_zad6_dmc_%0.3f.png', wsp_K);
%print(nazwa_pliku, '-dpng','-r400')