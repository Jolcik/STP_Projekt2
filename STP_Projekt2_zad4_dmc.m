sys_dyskretny = tf([0.03894 0.0343], [1 -1.66473 0.68628], 0.5, 'InputDelay', 10);
s = step(sys_dyskretny, 100);

Dn = 30;

N = Dn;
Nu = Dn;
D = Dn;
lambda = 1;

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



kk = 120;
u = zeros(kk, 1);
d_upk = zeros(1, D-1);
y = zeros(kk, 1);
y_zad = zeros(kk, 1);
y_zad(15:kk) = 1; 
e = zeros(kk, 1);

for k = 13:kk
    y(k) = 1.66473*y(k-1) - 0.68628*y(k-2) + 0.03894*u(k-11) + 0.0343*u(k-12);
    e(k) = y_zad(k)-y(k);
    
    d_upk(2:D-1) = d_upk(1:D-2);
    d_uk = ke*e(k) - ku*d_upk';
    d_upk(1) = d_uk;
    u(k) = u(k-1) + d_uk;
end

stairs(y);
hold on
plot(y_zad, ':')
hold off

legend('Wyjście obiektu', 'Wartość zadana')
xlabel('k')
ylabel('y(k)')
ylim([0 1.4])
tytul_wykresu = sprintf('Regulacja algorytmem DMC dla równych długości horyzontów D = %d', D);
title(tytul_wykresu)
nazwa_pliku = sprintf('STP_projekt2_zad5_a_D%d', D);
%print(nazwa_pliku,'-dpng','-r400');