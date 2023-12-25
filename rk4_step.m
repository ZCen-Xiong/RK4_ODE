function [t, y] = rk4_step(odefunc, t0, y0, h_val)
    % 使用四阶龙格库塔方法计算微分方程组的单步解
    %
    % 输入参数：
    %   odefunc：微分方程组的函数句柄，形如 dydt=f(t, y)，其中 t 是当前时间，y 是当前状态向量
    %   t0：初始时间
    %   y0：初始状态向量（行向量）
    %   h：时间步长
    %
    % 输出参数：
    %   t：下一个时间点
    %   y：下一个时间点的状态向量（行向量）
    %
    % 以下为了对付mex中的编译错误
    k1 = odefunc(t0, y0');
    k_len = length(k1);
    h = zeros(k_len,1);
    for i = 1:k_len
        h(i) = h_val; 
    end
    %
    k2 = odefunc(t0 + h_val / 2, y0' + h.* k1/ 2);
    k3 = odefunc(t0 + h_val / 2, y0' + h.* k2 / 2);
    k4 = odefunc(t0 + h_val, y0' + h.* k3);
    t = t0 + h_val;
    y = (y0 + h' .* (k1' + 2 * k2' + 2 * k3' + k4') / 6);

end
