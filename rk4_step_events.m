function [t, y, te, ye, ie] = rk4_step_events(odefunc, t0, y0, h, events,tetol)
    % ʹ���Ľ����������������΢�ַ�����ĵ����⣨���¼�������
    %
    % ���������
    %   odefunc��΢�ַ�����ĺ������������ dydt=f(t, y)������ t �ǵ�ǰʱ�䣬y �ǵ�ǰ״̬����
    %   t0����ʼʱ��
    %   y0����ʼ״̬��������������
    %   h��ʱ�䲽��
    %   events: �¼������ĺ������������ events(t, y)
    %
    % ���������
    %   t����һ��ʱ���
    %   y����һ��ʱ����״̬��������������
    %   te:�¼���ʱ��
    %   ye:�¼�ʱ��Ľ�
    %   ie:�������¼�����������
    te = [];
    ye = [];
    ie = [];
    if nargin < 6
        tetol = 0.01; % Ĭ��ֵΪ 0.01
    end
    [eventValue, ~, ~] = events(t0, y0); %t0ʱ���¼�
    [tNext, yNext] = rk4_step(odefunc, t0, y0, h); %����һ��
    [eventValueNext, ~, ~] = events(tNext, yNext); %tNextʱ���¼�

    if any(eventValueNext == 0) %�¼�ǡ�÷���
        t = tNext;
        y = yNext;
        te = tNext;
        ye = yNext;
        ie = find(eventValueNext == 0, 1, "first"); %��һ���¼�����ֵΪ0���¼�����
    elseif any(eventValue .* eventValueNext < 0)
        % eventValue .* eventValueNext����С��0
        % ��ʾvalue��t0-tNext֮���ţ�������㣬�¼�����
        index = find(eventValue .* eventValueNext < 0); %�¼�����������
        %���ַ����te��ȷֵ
        te_init = inf * ones(1, length(eventValueNext)); %te���г�ʼ��Ϊinf������ȡmin

        for ii = 1:1:length(index)
            %���������ʼ��
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
        [te, ie] = min(te_init); %ȡ���緢�����¼�ʱ����Ϊte
        h2 = te - t0;
        [tNext, yNext] = rk4_step(odefunc, t0, y0, h2);
        t = tNext;
        y = yNext;
        ye = yNext;
    else %�¼�������
        t = tNext;
        y = yNext;
    end

end
