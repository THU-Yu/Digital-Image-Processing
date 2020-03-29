function NewI = Comic(Src,gamma)
    Src = imbilatfilt(Src);
    for i = 1:3
        Edge = edge(Src(:,:,i),'Canny');
        Src(:,:,i) = Src(:,:,i) - Edge;
    end
    Src_hsv = rgb2hsv(Src);
    Src_hsv(:,:,2) = Src_hsv(:,:,2) .^ gamma;
    NewI = hsv2rgb(real(Src_hsv));