
function plot_signal(p1,p2,raw_data,filtered_data,removed_data)
subplot(3,2,1);
b_raw = raw_data{p1,p2,1}(:,1);
t_raw = raw_data{p1,p2,3}(:,1);
hold on
plot(b_raw);
plot(t_raw);
legend("baseline 1","tumor 1");
hold off
title("Time domain raw signal");
xlabel("Sample");
ylabel("Voltage");
axis([0,4100,-0.45,0.45]);

subplot(3,2,2);
hold on
frequencyplot(b_raw);
frequencyplot(t_raw);
legend("baseline 1","tumor 1");
hold off
title("Frequency spectrum raw signal");
xlabel("Frequency(Hz)");
ylabel("Magnitude");

subplot(3,2,3);
b_fil = filtered_data{p1,p2,1};
t_fil = filtered_data{p1,p2,3};
hold on
plot(b_fil);
plot(t_fil);
legend("baseline 1","tumor 1");
hold off
title("Time domain filtered signal");
xlabel("Sample");
ylabel("Voltage");
axis([0,4100,-0.45,0.45]);



subplot(3,2,4);
hold on
frequencyplot(b_fil);
frequencyplot(t_fil);
legend("baseline 1","tumor 1");
hold off
title("Frequency spectrum filtered signal");
xlabel("Frequency(Hz)");
ylabel("Magnitude");

subplot(3,2,5);
b_rem = removed_data{p1,p2,1};
t_rem = removed_data{p1,p2,3};
hold on 
plot(b_rem);
plot(t_rem);
legend("baseline 1","tumor 1");
hold off
title("Time domain removed signal");
xlabel("Sample");
ylabel("Voltage");
axis([0,4100,-0.45,0.45]);

subplot(3,2,6);
hold on
frequencyplot(b_rem);
frequencyplot(t_rem);
legend("baseline 1","tumor 1");
hold off
title("Frequency spectrum filtered signal");
xlabel("Frequency(Hz)");
ylabel("Magnitude");

t = strcat("Antenna pair A", int2str(p1)," - ", int2str(p2));
sgtitle(t);


end


