T = [1; 1.1; 1.2; 1.3; 1.4; 1.5; 1.6; 1.7; 1.8; 1.9; 2];

K_pid = [
    1.895
    1.810
    1.733
    1.663
    1.599
    1.540
    1.483
    1.430
    1.380
    1.332
    1.286
];

K_dmc = [
    2.012
    1.973
    1.907
    1.821
    1.728
    1.637
    1.257
    1.014
    0.867
    0.791
    0.769
];

plot(T, K_pid)
hold on
plot(T, K_dmc)
hold off
ylim([0.7 2.1])
xlabel('T0/T0nom')
ylabel('K0/K0nom')
legend('Algorytm PID', 'Algorytm DMC')
title('Obszary stabilności algorytmów PID i DMC')
print('STP_projekt2_zad6_wykresy','-dpng','-r400');