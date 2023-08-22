 
q = 15; %墙初始温度
q0= 18;
q0_index = linspace(18,22,600);
total_time =[];
hold on
for j = 1:1:1
    q0 = q0_index(j);
    t0 = 0; %初始时间
    res = []; %室内温度曲线
    wall_res = []; %墙温度曲线
    time = [];
    time_index = [0];%存放t0的索引
    for n = 1:1:25
        [tn,xn] = ode45('f',[t0:10: 24*60*60],[q0;q]);
        length1 = size(xn);
        for in = 1:1:length1(1)
        if xn(in) >22 
        break
        end
        end
        t0 = tn(in); %到22度的时间点
        q = xn(in,2);
        res = [res;xn(1:1:in,1)];
        wall_res = [wall_res ; xn(1:1:in,2)];
        time = [time;tn(1:1:in,1)];
        time_index = [time_index t0];
        [tn2,xn2] = ode45('f2',[t0:10: 24*60*60],[22;q]);
        length = size(xn2);
        for in2 = 1:1:length(1)
        if xn2(in2) <18
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
   total_time =[total_time;time_index];
   plot1 = plot(time,res,'LineWidth',2);
   plot1.Color(4) =0.3;
   
end
hold off