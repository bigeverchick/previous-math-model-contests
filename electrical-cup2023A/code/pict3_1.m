time_floor = floor(1/60 * total_time);
total_up_minute = [];
sum_up_power = linspace(0,0,1441);
for i =1 :1:600
    minute_up = linspace(0,0,1441);
    for j = 1:2 :75
    n = time_floor(i,j);
    n2 = time_floor(i,j+1);
    minute_up(n+1:1:n2+1) = 1;
    end
    total_up_minute= [total_up_minute;minute_up];
    sum_up_power = total_up_minute(i,:) + sum_up_power;
end
plot(linspace(0,300,301),8 * sum_up_power(961:1:1261),[0,300],[2423.224,2423.224])
xlabel('时间点/分钟')
ylabel('总功率/kW')
sum(sum_up_power(1:1:241))/240*8
