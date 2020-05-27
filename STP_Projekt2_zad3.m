Kr = 0.405;
Ki = 1/10;
Kd = 0.5*2.4;

sys_ciagly = tf([0.3526], [1 0.7529 0.1037], 'InputDelay', 5);
regulator = pid(Kr, Ki, Kd);
sprzezenie_zwrotne = feedback(regulator*sys_ciagly, 1);

hold on
step(sprzezenie_zwrotne);
hold off
xlim([0 200])
xlabel('czas')
ylabel('wyjście obiektu')

tytul_wykresu = sprintf('Wyjście obiektu dla Kr = %0.3f', Kr);
title(tytul_wykresu);

nazwa_pliku = sprintf('STP_projekt2_zad3_%0.3f_2.png', Kr);
print(nazwa_pliku,'-dpng','-r400')

