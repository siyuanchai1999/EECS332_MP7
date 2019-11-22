function error = CC(imgA, x, y, w, h, imgB, u, v)
    truncA = double(imgA(y : y + h - 1, x : x + w - 1));
    truncB = double(imgB(v : v + h - 1, u : u + w - 1));
    error = sum(sum((truncA .* truncB)));

end