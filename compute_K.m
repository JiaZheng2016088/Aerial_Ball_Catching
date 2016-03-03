function [ K_x, K_y, cnt ] = compute_K( r )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

K_img = zeros(2*r+1, 2*r+1, 2); % K_img(:,:,1) stores x component in image coordinate
x0 = r+1;
y0 = r+1;
x = r;  % horizontal image coordinate
y = 0;  % vertical image coordinate
decisionOver2 = 1 - x;
% store unit vectors with different directions into K
K_img(x0+x,y0,1) = 1; K_img(x0+x,y0,2) = 0;
K_img(x0-x,y0,1) = -1; K_img(x0-x,y0,2) = 0;
K_img(x0,y0+x,1) = 0; K_img(x0,y0+x,2) = 1; 
K_img(x0,y0-x,1) = 0; K_img(x0,y0-x,2) = -1;
cnt = 4;

while( y<x )    
    if y>0
        K_img(x+x0, y+y0, :) = [x, y]/norm([x, y]);
        K_img(y+x0, x+y0, :) = [y, x]/norm([y, x]);
        K_img(-x+x0, y+y0, :) = [-x, y]/norm([-x, y]);
        K_img(-y+x0, x+y0, :) = [-y, x]/norm([-y, x]);
        K_img(-x+x0, -y+y0, :) = [-x, -y]/norm([-x, -y]);
        K_img(-y+x0, -x+y0, :) = [-y, -x]/norm([-y, -x]);
        K_img(x+x0, -y+y0, :) = [x, -y]/norm([x, -y]);
        K_img(y+x0, -x+y0, :) = [y, -x]/norm([y, -x]);   
        cnt = cnt + 8;
    end;
    y = y+1;
    if(decisionOver2<=0)
        decisionOver2 = decisionOver2 + 2*y + 1;
    else
        x = x-1;
        decisionOver2 = decisionOver2 + 2*(y-x) + 1;
    end;
end;

if y==x
    K_img(x+x0, y+y0, :) = [x, y]/norm([x, y]);
    K_img(-x+x0, y+y0, :) = [-x, y]/norm([-x, y]);
    K_img(-x+x0, -y+y0, :) = [-x, -y]/norm([-x, -y]);
    K_img(x+x0, -y+y0, :) = [x, -y]/norm([x, -y]);
    cnt = cnt + 4;
end;


K_x = K_img(:,:,2);
K_y = K_img(:,:,1);

end

