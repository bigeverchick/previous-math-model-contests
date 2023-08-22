%先开后关
t0 = 0;
res = [];
time = [];
q = 15;
time_index = [0];%存放t0的索引
wall_res = [];
total_res = [];
q0= 18.8;
for n = 1:1:37
    [tn,xn] = ode45('f',[t0:10: 24*60*60],[q0;q]);
    length1 = size(xn);
    for in = 1:1:length1(1)
    if xn(in) >= 22 
    break
    end
    end
    t0 = tn(in);
    q = xn(in,2);
    res = [res;xn(1:1:in,1)];
    wall_res = [wall_res ; xn(1:1:in,2)];
    time = [time;tn(1:1:in,1)];
    time_index = [time_index t0];
    [tn2,xn2] = ode45('f2',[t0:10: 24*60*60],[22;q]);
    length = size(xn2);
    for in2 = 1:1:length(1)
    if xn2(in2) <= 18
        break
    end
    end
    t0 = tn2(in2);
    q = xn2(in2,2);
    res = [res;xn2(1:1:in2,1)];
    wall_res = [wall_res ; xn2(1:1:in2,2)];
    time = [time;tn2(1:1:in2,1)];
    time_index = [time_index t0];
    q0 = 18;
   
end




%subplot(2,1,1)
hold on
plot1=plot(time,res,'LineWidth',2);
plot1.Color(4) =0.3;

%plot(time,wall_res,'LineWidth',2);
%plot( t([1:1:i]),x([1:1:i]));
%subplot(2,1,2)
t_on = 0;
t_off = 0;
time_index_s =time_index;


for i = 1: 2 : 74

plot_a = plot([time_index(i),time_index(i+1)],[8,8],'b','LineWidth',2);
plot_a.Color(4) = 0.3;
t_off = t_off + (time_index(i+1)-time_index(i));
plot_b = plot([time_index(i),time_index(i)],[8,0],'b','LineWidth',2);
plot_b.Color(4) = 0.3;
plot_c = plot([time_index(i+1),time_index(i+1)],[8,0],'b','LineWidth',2);
plot_c.Color(4) = 0.3;
plot_d = plot([time_index(i+1),time_index(i+2)],[0,0],'b','LineWidth',2);
plot_d.Color(4) = 0.3;
t_on = t_on + (time_index(i+2)-time_index(i+1));
end
%xticks(time_index)
%legend('室内温度','墙体温度','功率');
yticks(0:2:22);
xlabel('时间(分钟)');
ylabel('功率');

grid on;

hold off

for i = 1: 2 : 58
plot([time_index(i),time_index(i+1)],[time_index(i+1)-time_index(i),0],'r','LineWidth',2);
end

for i = 1: 2 : 58
plot([time_index(i+1),time_index(i+2)],[time_index(i+2)-time_index(i+1),0],'r','LineWidth',2);
end

%调节功率曲线计算
time_index = time_index * 1/60;
minute_index = 0:1:1440;
up_minute = zeros(1,1441);
down_minute = zeros(1,1441);
flag = 2;
for i = 1:1:1441
    if minute_index(i) <= time_index(flag+1)
        if minute_index(i) <= time_index(flag)
        up_minute(i) = time_index(flag)- minute_index(i);
        end
        if minute_index(i) > time_index(flag)
        up_minute(i) = 0;
        down_minute(i) = time_index(flag+1)- minute_index(i);
        end
    end
    if minute_index(i) > time_index(flag+1)
        flag = flag+2;
        size_time_index = size(time_index);
        if size_time_index(2) <flag 
            break
        end
        up_minute(i) = time_index(flag)- minute_index(i);
    end
end

plot(0:1:1440,up_minute,'LineWidth',1.5)
plot(0:1:1440,down_minute,'LineWidth',1.5)
legend('可参与上调时间','可参与下调时间')

