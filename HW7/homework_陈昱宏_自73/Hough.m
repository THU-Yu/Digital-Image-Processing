function houghspace = Hough(bw,r_min,r_max,step_angle)
    [h,w] = size(bw);
    r_size = (r_max - r_min);
    angle_size = round(2*pi/step_angle);
    % 建立圆检测的霍夫空间
    houghspace = zeros(h,w,r_size);
    % 计算需要迭代的次数，即二值图像的白像素点个数
    [rows,cols] = find(bw);
    point_num = size(rows);
    % 霍夫变换
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
    
    