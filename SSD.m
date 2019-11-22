function error = SSD(imgA, x, y, w, h, imgB, u, v)
    truncA = double(imgA(y : y + h - 1, x : x + w - 1));
    truncB = double(imgB(v : v + h - 1, u : u + w - 1));
    
    error = sum(sum((truncA - truncB).^2));
    
%     if frame == 15
%         toDisp = ["u = ", u, " v = ", v, "err = ", error]; disp(toDisp);
%         figure;
%         imshow(truncB);
%     end

end