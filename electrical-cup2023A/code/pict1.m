%[t,x] = ode45('f',0 : 1 :24*60*60,[18;15]);

%[t1,x1] = ode45('f2',[t(i) 24*60*60],[22;15]);

clear all
t0 = 0;
res = [];
time = [];
q = 13.8;
time_index = [0];%存放t0的索引
wall_res = [];
q0= 20;
for n = 1:1:30
    
    [tn,xn] = ode45('f2',[t0:10: 24*60*60],[q0;q]);
    length1 = size(xn);
    for in = 1:1:length1(1)
    if xn(in) <18  
    break
    end
    end
    t0 = tn(in);
    q = xn(in,2);
    res = [res;xn(1:1:in,1)];
    wall_res = [wall_res ; xn(1:1:in,2)];
    time = [time;tn(1:1:in,1)];
    time_index = [time_index t0];
    [tn2,xn2] = ode45('f',[t0:10: 24*60*60],[18;q]);
    length = size(xn2);
    for in2 = 1:1:length(1)
    if xn2(in2) >22
    break
    end
    end
    t0 = tn2(in2);
    q = xn2(in2,2);
    res = [res;xn2(1:1:in2,1)];
    wall_res = [wall_res ; xn2(1:1:in2,2)];
    time = [time;tn2(1:1:in2,1)];
    time_index = [time_index t0];
    q0 = 22;
end




%subplot(2,1,1)
hold on
plot(time,res,'LineWidth',2);
plot(time,wall_res,'LineWidth',2);
%plot( t([1:1:i]),x([1:1:i]));
%subplot(2,1,2)
t_on = 0;
t_off = 0;

for i = 1: 2 : 60

plot([time_index(i),time_index(i+1)],[0,0],'r','LineWidth',2);
t_off = t_off + (time_index(i+1)-time_index(i));
plot([time_index(i),time_index(i)],[0,8],'r','LineWidth',2);
plot([time_index(i+1),time_index(i+1)],[0,8],'r','LineWidth',2);
plot([time_index(i+1),time_index(i+2)],[8,8],'r','LineWidth',2);
t_on = t_on + (time_index(i+2)-time_index(i+1));
end
%xticks(time_index)
legend('室内温度','墙体温度','功率');
yticks(0:2:22);
xlabel('时间');
ylabel('温度/功率');

grid on;

hold off