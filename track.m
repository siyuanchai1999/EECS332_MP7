function track(method)
    frames_gray = uint8(zeros(500, 96, 128));
    frames_color = uint8(zeros(500, 96, 128, 3));

    for i = 1 : 500
       img = imread(getPath(i));
       frames_color(i, :, :, :) = img;
       frames_gray(i, :, :) = rgb2gray(img);
    end

    x = 54;
    y = 20;
    w = 38;
    h = 45;
    H = 96; W = 128;
    search_range = 40;
    errMatrix = zeros(search_range * 2 + 1, search_range * 2 + 1);

    % show first image
    fig = figure('visible', 'off');
    init_template = squeeze(frames_gray(1, :, :, :));
    init_x = x; init_y = y;
    imshow(init_template);
    rectangle('Position', [x, y, w, h]);
%     subfolder = 'SSD\';
    saveas(fig, pwd + "\data\" + method + "\" + int2str(1) + ".png");

    fig = figure('visible', 'off');
    for f = 2 : 500
       toDisp = ["f = ", f]; disp(toDisp);
       
       prev_img = squeeze(frames_gray(f - 1, :, :));
       curr_img = squeeze(frames_gray(f, :, :));
       errMatrix(:, :) = inf;
       if(method == "NCC")
           errMatrix = errMatrix * -1;
       end
       
       template = prev_img;
       sample_x = x;
       sample_y = y;
       % compare to initial frame in blocked situation
       if(f == 122 | f == 262 | f == 443 | f == 468)
           template = init_template;
           sample_x = init_x;
           sample_y = init_y;
       end
       
       
       for dy = 1 : size(errMatrix, 1)
           for dx = 1 : size(errMatrix, 2)

               u = x + dx - (search_range + 1);
               v = y + dy - (search_range + 1);
    %            new index out of boundary
                if(u < 1 || v < 1 || u > W || v > H)
                   continue
               end 
    %            new box out of boundary
               if(u + w > W || v + h > H)
                   continue
               end

               if method == "SSD"
                   errMatrix(dy, dx) = SSD(template, sample_x, sample_y, w, h, curr_img, u, v);
               elseif method == "CC"
                   errMatrix(dy, dx) = CC(template, sample_x, sample_y, w, h, curr_img, u, v);
               elseif method == "NCC"
                   errMatrix(dy, dx) = NCC(template, sample_x, sample_y, w, h, curr_img, u, v);
               end
           end
       end

    %    get the minimum error / maximum correlation
       [v, pos] = min(errMatrix, [], 2);
       [d, r] =  min(v);
       if method == "NCC"
            [v, pos] = max(errMatrix, [], 2);
            [d, r] = max(v);
       end
       
       c = pos(r);
        
       if f == 183
           x = x + 8;
       end
       x = x + c - (search_range + 1);
       y = y + r - (search_range + 1);
       toDisp = ["x = ", x, "y = ", y]; disp(toDisp);

            
       imshow(squeeze(frames_color(f, :, :, :)));
       rectangle('Position', [x, y, w, h]);
       saveas(fig, pwd + "\data\" + method + "\" + int2str(f) + ".png");
    end
end