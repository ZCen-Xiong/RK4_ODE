function [t, y, te, ye, ie] = rk4_step_events(odefunc, t0, y0, h, events,tetol)
    % 使用四阶龙格库塔方法计算微分方程组的单步解（含事件函数）
    %
    % 输入参数：
    %   odefunc：微分方程组的函数句柄，形如 dydt=f(t, y)，其中 t 是当前时间，y 是当前状态向量
    %   t0：初始时间
    %   y0：初始状态向量（行向量）
    %   h：时间步长
    %   events: 事件函数的函数句柄，形如 events(t, y)
    %
    % 输出参数：
    %   t：下一个时间点
    %   y：下一个时间点的状态向量（行向量）
    %   te:事件的时间
    %   ye:事件时间的解
    %   ie:触发的事件函数的索引
    te = [];
    ye = [];
    ie = [];
    if nargin < 6
        tetol = 0.01; % 默认值为 0.01
    end
    [eventValue, ~, ~] = events(t0, y0); %t0时刻事件
    [tNext, yNext] = rk4_step(odefunc, t0, y0, h); %积分一步
    [eventValueNext, ~, ~] = events(tNext, yNext); %tNext时刻事件

    if any(eventValueNext == 0) %事件恰好发生
        t = tNext;
        y = yNext;
        te = tNext;
        ye = yNext;
        ie = find(eventValueNext == 0, 1, "first"); %第一个事件函数值为0的事件索引
    elseif any(eventValue .* eventValueNext < 0)
        % eventValue .* eventValueNext数组小于0
        % 表示value在t0-tNext之间变号，穿过零点，事件发生
        index = find(eventValue .* eventValueNext < 0); %事件发生的索引
        %二分法求解te精确值
        te_init = inf * ones(1, length(eventValueNext)); %te序列初始化为inf，方便取min

        for ii = 1:1:length(index)
            %左右区间初始化
            t_left = t0;
            y_left = y0;
            t_right = tNext;
            y_right = yNext;
            eventValue_left = eventValue;
            eventValue_right = eventValueNext;

            while ((t_right - t_left) > h * tetol)
                [t_mid, y_mid] = rk4_step(odefunc, t_left, y_left, (t_right - t_left) / 2);
                [eventValue_mid, ~, ~] = events(t_mid, y_mid);

                if eventValue_left(index(ii)) * eventValue_mid(index(ii)) <= 0
                    t_right = t_mid;
                    y_right = y_mid;
                else
                    t_left = t_mid;
                    y_left = y_mid;
                end

            end

            te_init(index(ii)) = t_left;
        end 
        [te, ie] = min(te_init); %取最早发生的事件时刻作为te
        h2 = te - t0;
        [tNext, yNext] = rk4_step(odefunc, t0, y0, h2);
        t = tNext;
        y = yNext;
        ye = yNext;
    else %事件不发生
        t = tNext;
        y = yNext;
    end

end
