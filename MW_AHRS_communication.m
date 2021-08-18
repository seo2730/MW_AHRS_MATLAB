clear all
close all
serialportlist
s = serialport("COM24",115200);
configureTerminator(s,"CR/LF");
writeline(s,"sp=10") %데이터 전송주기 [ms]
writeline(s,"as=3") % 가속도 스케일
writeline(s,"gs=3")
writeline(s,"zro") % 각도 데이터 리셋
% writeline(s,"cmd=4")
% writeline(s,"cmd=9") % 캘리브레이션 데이터 리셋
% writeline(s,"ss=1") % 가속도
% writeline(s,"ss=2") % 각속도
% writeline(s,"ss=3") % 가속도, 각속도
% writeline(s,"ss=4") % 각도
% writeline(s,"ss=5") % 가속도, 각도
% writeline(s,"ss=6") % 각속도, 각도
% writeline(s,"ss=7") % 가속도, 각속도, 각도
% writeline(s,"ss=8") % 자기
% writeline(s,"ss=9") % 가속도, 자기
% writeline(s,"ss=10") % 각속도, 자기
% writeline(s,"ss=11") % 가속도, 각속도, 자기 
writeline(s,"ss=15") % 가속도, 각속도,  각도, 자기
sampling_time = 0.1;
x_pos = 0;
y_pos = 0;
x_vel = 0;
y_vel = 0;
timestep = 1;
Nsamples = 1800;
time_interval = 0:sampling_time:Nsamples;
% save_data = zeros(time_interval, 7);
% real_data = zeros(1,6);
firstrun = [];
pre_data = zeros(1,7);
for t = 1:Nsamples
   tic;
   if mod(t,10) == 0
        rawdata = readline(s);
        disp(rawdata)
        data_str = split(rawdata);
        data = double(data_str);


        if size(data,1) >2
            x_acc = data(2);
            y_acc = data(3);
            theta = data(7);
            timestep = timestep + 1;
        end
        
        toc;
   end
    
end

s.Terminator