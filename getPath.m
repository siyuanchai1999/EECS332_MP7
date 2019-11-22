function path = getPath(frame)
    folder = "image_girl\";
    chr = int2str(frame);
    pad = "0";
    while(strlength(chr) + strlength(pad) < 4)
        pad = append(pad, '0');
    end
    path = folder + pad + chr + ".jpg";
%     disp( path);
 end


