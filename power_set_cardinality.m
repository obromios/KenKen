function [ sub_sets ] = power_set_cardinality( in_set,cadin_no )
%power_set_cardinality
%  This function produces all the subsets of in_set with a cardinality of
%  cardin_no

N=length(in_set)
sub_sets = [];
for i = 1:N
    bin_rep = dec2bin(i);
    sum = 0;
    set_instance = [];
    for j=1:length(bin_rep)
        if bin_rep(j) == '1'
            sum = sum +1;
            set_instance = [set_instance,in_set(j)]
        end
    end
    if sum == cardin_no
         sub_sets = [sub_sets;set_instance]
    end

end

