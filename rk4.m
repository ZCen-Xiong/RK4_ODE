function [t, y] = rk4(odefunc, tspan, y0, h)
    % ʹ���Ľ��������������ֵ���΢�ַ�����
    %
    % ���������
    %   odefunc��΢�ַ�����ĺ������������ f(t, y)������ t �ǵ�ǰʱ�䣬y �ǵ�ǰ״̬����
    %   tspan������ʱ�������յ������������ [t0, tn]
    %   y0��״̬������ʱ����� t0 ��ֵ����������
    %   h��ʱ�䲽��
    %
    % ���������
    %   t����ֵ���ʱ�������
    %   y����ֵ�����ÿһ�а�����Ӧʱ����µ�״̬�����Ľ�
    if nargin < 4
        h = 0.01; % ����Ĭ�ϲ���
    end

    if size(tspan) ~= [1, 2]
        error(message('MATLAB:rk4:WrongDimensionOfTspan'));
    end

    % ��ʼ��
    t0 = tspan(1); % ���
    tn = tspan(2); % �յ�
    n = floor((tn - t0) / h); % ���㲽��
    t = zeros(n + 1, 1); % ��ʼ��ʱ����������������
    y = zeros(n + 1, length(y0)); % ��ʼ��״̬����
    t(1) = t0; % ����ֵ
    y(1, :) = y0; % ����ֵ

    for i = 1:n
        [t(i + 1), y(i + 1, :)] = rk4_step(odefunc, t(i), y(i, :), h);
    end

end
