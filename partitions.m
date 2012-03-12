function [ out_set ] = partitions( in_set,len,dim )
% [ out_set ] = partitions( in_set,len )
%   produces all the partions of in_set of number len

M = length(in_set);
all_list = SetPartition(M,len);
[n,m] = size(all_list);
out_set = [];
for i=1:n
    for j = 1:len
        parti = cell2mat(all_list{i,1}(j));
        clear chosen_ones;
        for k=1:length(parti);
            chosen_ones(k) = in_set(parti(k));
        end
        trial(1,j) = prod(chosen_ones);
    end
    if max(trial) <= dim
        new_entry = 1;
        [n_c,n_r]=size(out_set);
        for k = 1:n_c
            if length(setdiff(trial,out_set(k,:))) == 0
                new_entry = 0;
            end
        end
        if new_entry == 1
            out_set = [out_set;trial];
        end
    end
end
end

