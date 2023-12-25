function [t, y, te, ye, ie] = rk4_events(odefunc, tspan, y0, h, events)
    % 使用四阶龙格库塔方法数值求解微分方程组（含事件函数）
    %
    % 输入参数：
    %   odefunc：微分方程组的函数句柄，形如 f(t, y)，其中 t 是当前时间，y 是当前状态向量
    %   tspan：包含时间起点和终点的向量，形如 [t0, tn]
    %   y0：状态向量在时间起点 t0 的值（行向量）
    %   h：时间步长
    %   events: 事件函数的函数句柄，形如 events(t, y)
    %
    % 输出参数：
    %   t：数值解的时间点向量
    %   y：数值解矩阵，每一行包含对应时间点下的状态向量的解
    %   te:事件的时间
    %   ye:事件时间的解
    %   ie:触发的事件函数的索引
    if nargin < 4
        h = 0.01; % 设置默认步长
    end

%     if size(tspan) ~= [1, 2]
%         error(message('MATLAB:rk4:WrongDimensionOfTspan'));
%     end

    % 初始化
    t0 = tspan(1); % 起点
    tn = tspan(2); % 终点
    n = floor((tn - t0) / h); % 计算步数
    t = zeros(n + 1, 1); % 初始化时间向量（列向量）
    y = zeros(n + 1, length(y0)); % 初始化状态矩阵
    t(1) = t0; % 赋初值
    y(1, :) = y0; % 赋初值
    te = [];
    ye = [];
    ie = [];

    for i = 1:n
        [t(i + 1), y(i + 1, :), te, ye, ie] = rk4_step_events(odefunc, t(i), y(i, :), h, events);

        if isempty(te) % te无元素，无事件发生
        else
            t(i + 2:end) = [];
            y(i + 2:end, :) = [];
            break;
        end

    end

end
