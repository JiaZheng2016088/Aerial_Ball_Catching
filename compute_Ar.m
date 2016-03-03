function [ Ar ] = compute_Ar(r, C, K, num_K)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[I_m, I_n] = size(C(:,:,1));
C_x = C(:,:,1);
C_y = C(:,:,2);
K_x = K(:,:,1);
K_y = K(:,:,2);
Ar = zeros(I_m, I_n);
for row=(r+1):I_m-(r+1)
    for column=(r+1):I_n-(r+1)
        %if row == 126 && column == 717
        %if row == 178 && column == 552
            temp = C_x(row-r:row+r, column-r:column+r).*K_x + C_y(row-r:row+r, column-r:column+r).*K_y;
%             quiver(C_x(row-r:row+r, column-r:column+r),C_y(row-r:row+r, column-r:column+r))
%             hold on;
%             quiver(K_x, K_y);
%             idx = temp<=0;
%             temp(idx) = 0;
            Ar(row,column) = (1/num_K)*sum(sum((temp.^2)));
        %end;
    end;
end;

end

