function houghspace = Hough(bw,r_min,r_max,step_angle)
    [h,w] = size(bw);
    r_size = (r_max - r_min);
    angle_size = round(2*pi/step_angle);
    % ����Բ���Ļ���ռ�
    houghspace = zeros(h,w,r_size);
    % ������Ҫ�����Ĵ���������ֵͼ��İ����ص����
    [rows,cols] = find(bw);
    point_num = size(rows);
    % ����任
    % a = x - rcos(theta)
    % b = y - rsin(theta)
    for i = 1:point_num
        for j = 1:r_size
            for k = 1:angle_size
                a = round(rows(i)-(r_min+j-1)*cos(k*step_angle));
                b = round(cols(i)-(r_min+j-1)*sin(k*step_angle));
                if (a>0&&a<=h&&b>0&&b<=w)
                    houghspace(a,b,j) = houghspace(a,b,j) + 1;
                end
            end
        end
    end
    
    