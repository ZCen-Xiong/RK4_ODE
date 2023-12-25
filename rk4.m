function [t, y] = rk4(odefunc, tspan, y0, h)
    % 使用四阶龙格库塔方法数值求解微分方程组
    %
    % 输入参数：
    %   odefunc：微分方程组的函数句柄，形如 f(t, y)，其中 t 是当前时间，y 是当前状态向量
    %   tspan：包含时间起点和终点的向量，形如 [t0, tn]
    %   y0：状态向量在时间起点 t0 的值（行向量）
    %   h：时间步长
    %
    % 输出参数：
    %   t：数值解的时间点向量
    %   y：数值解矩阵，每一行包含对应时间点下的状态向量的解
    if nargin < 4
        h = 0.01; % 设置默认步长
    end

    if size(tspan) ~= [1, 2]
        error(message('MATLAB:rk4:WrongDimensionOfTspan'));
    end

    % 初始化
    t0 = tspan(1); % 起点
    tn = tspan(2); % 终点
    n = floor((tn - t0) / h); % 计算步数
    t = zeros(n + 1, 1); % 初始化时间向量（列向量）
    y = zeros(n + 1, length(y0)); % 初始化状态矩阵
    t(1) = t0; % 赋初值
    y(1, :) = y0; % 赋初值

    for i = 1:n
        [t(i + 1), y(i + 1, :)] = rk4_step(odefunc, t(i), y(i, :), h);
    end

end
