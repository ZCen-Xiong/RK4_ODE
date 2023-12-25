function [t, y, te, ye, ie] = rk4_events(odefunc, tspan, y0, h, events)
    % ʹ���Ľ��������������ֵ���΢�ַ����飨���¼�������
    %
    % ���������
    %   odefunc��΢�ַ�����ĺ������������ f(t, y)������ t �ǵ�ǰʱ�䣬y �ǵ�ǰ״̬����
    %   tspan������ʱ�������յ������������ [t0, tn]
    %   y0��״̬������ʱ����� t0 ��ֵ����������
    %   h��ʱ�䲽��
    %   events: �¼������ĺ������������ events(t, y)
    %
    % ���������
    %   t����ֵ���ʱ�������
    %   y����ֵ�����ÿһ�а�����Ӧʱ����µ�״̬�����Ľ�
    %   te:�¼���ʱ��
    %   ye:�¼�ʱ��Ľ�
    %   ie:�������¼�����������
    if nargin < 4
        h = 0.01; % ����Ĭ�ϲ���
    end

%     if size(tspan) ~= [1, 2]
%         error(message('MATLAB:rk4:WrongDimensionOfTspan'));
%     end

    % ��ʼ��
    t0 = tspan(1); % ���
    tn = tspan(2); % �յ�
    n = floor((tn - t0) / h); % ���㲽��
    t = zeros(n + 1, 1); % ��ʼ��ʱ����������������
    y = zeros(n + 1, length(y0)); % ��ʼ��״̬����
    t(1) = t0; % ����ֵ
    y(1, :) = y0; % ����ֵ
    te = [];
    ye = [];
    ie = [];

    for i = 1:n
        [t(i + 1), y(i + 1, :), te, ye, ie] = rk4_step_events(odefunc, t(i), y(i, :), h, events);

        if isempty(te) % te��Ԫ�أ����¼�����
        else
            t(i + 2:end) = [];
            y(i + 2:end, :) = [];
            break;
        end

    end

end
