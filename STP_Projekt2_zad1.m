% sprawdzenie poprawności obliczeń wykonanych ręcznie
H_poprawnosc = tf([0.3526], [1 0.7529 0.1037], 'InputDelay', 5);
Hd_poprawnosc = c2d(H_poprawnosc, 0.5);

% transmitancje policzone ręcznie
sys_ciagly = tf([0.3526], [1 0.7529 0.1037], 'InputDelay', 5);
sys_dyskretny = tf([0.03894 0.0343], [1 -1.66473 0.68628], 0.5, 'InputDelay', 10);

[y_ciagly, t_ciagly] = step(sys_ciagly);

figure(1)
plot(t_ciagly, y_ciagly,  'Color', 'red');
hold on
step(sys_dyskretny);
hold off
title('Odpowiedzi skokowe transmitancji ciągłej i dyskretnej')
legend('Transmitancja ciągła', 'Transmitancja dyskretna')
xlabel('t')
ylabel('y')
ylim ([0 4.5])
print('STP_projekt2_zad1','-dpng','-r400')