function [t, y] = rk4_step(odefunc, t0, y0, h_val)
    % ʹ���Ľ����������������΢�ַ�����ĵ�����
    %
    % ���������
    %   odefunc��΢�ַ�����ĺ������������ dydt=f(t, y)������ t �ǵ�ǰʱ�䣬y �ǵ�ǰ״̬����
    %   t0����ʼʱ��
    %   y0����ʼ״̬��������������
    %   h��ʱ�䲽��
    %
    % ���������
    %   t����һ��ʱ���
    %   y����һ��ʱ����״̬��������������
    %
    % ����Ϊ�˶Ը�mex�еı������
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
