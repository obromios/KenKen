function [ output_args ] =  KenKenInput
% NOT COMPLETED
%This function interprets a KenKen file and plots 
% a graph to show that all squares are covered.
%  The input is a csv text file, each line of which
% describes a segment of the puzzle.
% the format is as follows:
%op,result,N,v1,...,vN)
% where op represents the type of operation and is = 1 or 2 or 3 or 4 for +,-,x,/ respectively
% or if op = 'd', then the last line of input is ignoreed and if op = 'e'
% process is terminated

% result = result of operation
% N = number of elements
% v1 etc is the location of the ith element, in column order, e.g if matrix
% is 3 x 3 then the first column is numbered from the top, 1,2,3, the second
% column, numbered from the top is 4,5,6 etc.
% all numbers are positive integers
%
% Dim is the dimension of the puzzle.

dim = input('What is dimension of puzzle?')
disp('Now input each puzzle block, in the format op,result,N,v1,...,vN')
disp('terminating by typing e <CR>')
i=1;
while 1==1
    txt = input(['block ',num2str(i),' >'],'s')
    if txt(1) == 'e'
        disp('input process complete')
        break
    elseif txt(1) == 'd'
        disp('line deleted')
    else
        ops(i) = txt(1);
        valid_input = 1;
        nums = num2str(txt(3:end));
        results(i) = nums(1);
        no_of_elements(i) = nums(2);
        positions{i} = nums(3:end);
        % now print out results
        i
        disp([ops(i),results(i)])
        for i=1:dim,for j=1:dim,Kengrid(i,j)='o';end,end
        for k = 1:dim*dim
            if find(nums(3:end)-k,1)>0
                Kengrid(k) = 'x';
            end
        end
        Kengrid
        i=i+1;
    end
end


end

