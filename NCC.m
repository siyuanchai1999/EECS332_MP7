function error = NCC(imgA, x, y, w, h, imgB, u, v)
    truncA = double(imgA(y : y + h - 1, x : x + w - 1));
    truncB = double(imgB(v : v + h - 1, u : u + w - 1));
    A_bar = mean(truncA(:));
    B_bar = mean(truncB(:));
    
    domin = sum(sum((truncA - A_bar) .* (truncB - B_bar)));
    A_var = sum(sum((truncA - A_bar).^2));
    B_var = sum(sum((truncB - B_bar).^2));
    
    error = domin / sqrt(A_var * B_var);
end