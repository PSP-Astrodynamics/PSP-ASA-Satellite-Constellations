figure
plot(1,1)
xlabel('Time [km]')
ylabel('Error in RTH [km]')
title('Error Between CWH and Keplerian Solutions')
legend('Radial Error', 'Longitudinal Error', 'Normal Error')
xlim([0, 6000])
ylim([-.2, 1.2])