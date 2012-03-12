function candidates = KenKen(op,result,no,dim,printit)
%KenKen(op,result,no,dim)
% provides assistance in solving KenKen puzzles
% op = 'x,/,+,-'
% result = end answer
% no = number of places
% dim of puzzle
% if printit = 1, the display output
candidates = [];
switch op
    case ('n')
        candidates = result;
    case {'x'}
        factors = factor(result);
        factors = [1,factors]; % add "1" as a default factor
        candidates = partitions( factors,no,dim );
        if length(candidates) == 0
            if printit,disp('No solutions found'),end
        end
        
    case {'+'}
        candidates = sub_add(dim,no,1,[],result,candidates,printit);
    case{'-'}
        switch no
            case{2}
                for i= dim:-1:1
                    for j=i:-1:1
                        residue = i-j;
                        if residue == result
                            if printit,disp([i,j]),end
                            candidates = [candidates;[i,j]];
                        end
                    end
                end
            otherwise
                warning('no is out of range for - operation')
        end
    case{'/'}
        switch no
            case{2}
                for i= dim:-1:1
                    for j=i:-1:1
                        resultant = i/j;
                        if resultant == result
                            if printit,disp([i,j]),end
                            candidates = [candidates;[i,j]];
                        end
                    end
                end
            otherwise
                warning('no is out of range for / operation')
        end
        
end
                
end
function candidates = sub_add(dim,no,level,vect,result,candidates,printit)
    for i= dim:-1:1
        if level < no
            candidates = sub_add(i,no,level+1,[vect,i],result,candidates,printit);
        else
            if i == dim
                vect = [vect,i];
            else
                vect(end) = i;
            end
            if sum(vect) == result
                if printit,disp(vect),end
                candidates = [candidates;vect];
            end
        end
    end
end
% function sub_multiply(dim,no,level,vect,result,factors)
%     for i= dim:-1:1
%         if level < no
%             sub_add(i,no,level+1,[vect,i],result)
%         else
%             if i == dim
%                 vect = [vect,i];
%             else
%                 vect(end) = i;
%             end
%             if prod(vect) == result
%                 disp(vect)
%             end
%         end
%     end
% end

%         switch no
%             case {2}
%                 for i=dim:-1:1
%                     for j = i:-1:1
%                         if((i+j) == result) && (i~=j)
%                             disp([i,j])
%                         end
%                     end
%                 end
%             case(3)
%                 for i=dim:-1:1
%                     for j = dim:-1:1
%                         for k = dim:-1:1
%                             sum = i+j+k;
%                             if sum == result
%                                 disp([i,j,k])
%                             end
%                         end
%                     end
%                 end
%                 
%             case(4)
%                 for i=dim:-1:1
%                     for j = dim:-1:1
%                         for k = dim:-1:1
%                             for dim=k:-1:1
%                                 sum = i+j+k+m;
%                                 if sum == result
%                                     disp([i,j,k,m])
%                                 end
%                         end
%                     end
%                 end
%                 
%                 end
%             otherwise
%                 warning('no is out of range for + operation')               
%         end