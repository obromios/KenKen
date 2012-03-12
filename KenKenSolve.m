function KenKenSolve
%functiont to solve KenKen puzzles
%   Detailed explanation goes here


dim = 3;  % dimensions of puzzle
no_regions = 6;  % number of regions puzzle is divided into
box_nos{1} = [1];  %  boxes (in vector order) in a region
box_nos{2} = [2,3];
box_nos{3} = [4,5];
box_nos{4} = [6];
box_nos{5}=[7,8];
box_nos{6}=[9];

ops = ['n','+','-','n','+','n'];
results = [1,5,1,1,3,3];

dim = 4;
no_regions = 9; 
ops     = ['+','-','-','n','-','-','-','n','-'];
%ops     = [+,-,-,n,-,-,-,n,-]
results = [3,1,3,3,2,3,1,3,3];
box_nos{1} = [1,2];
box_nos{2} = [5,9]; 
box_nos{3} = [13,14];
box_nos{4} = [6];
box_nos{5} = [10,11];
box_nos{6} = [3,7];
box_nos{7} = [15,16];
box_nos{8} = [4];
box_nos{9} = [8,12];

% dim=6
% no_regions = 17
% ops =      ['x','n','+','+','x','-','n','+','+','+','n','+','/','-','-','/','n'];
% results =  [180,2,5,11,40,3,3,11,8,13,1,7,2,5,2,3,5];
% 
% box_nos{1} = [1,7,8];
% box_nos{2} = [2];
% box_nos{3} = [3,9];
% box_nos{4} = [4,5,11];
% box_nos{5} = [10,16,22];
% box_nos{6} = [13,14];
% box_nos{7} = [15];
% box_nos{8} = [17,18,12,6];
% box_nos{9} = [19,20];
% box_nos{10} = [21,27,33];
% box_nos{11} = [23];
% box_nos{12} = [24,30];
% box_nos{13} = [25,26];
% box_nos{14} = [28,34];
% box_nos{15} = [29,35];
% box_nos{16} = [31,32];
% box_nos{17} = [36];

% solution is
% 
% 654321
% 261543
% 413652
% 345216
% 532164
% 126435

print_puzzle(dim,ops,results,box_nos);

for i = 1:no_regions
     linear_box(i) = linear_check(box_nos{i},dim)
end

for i = 1:no_regions
    candidates{i} = KenKen(ops(i),results(i),length(box_nos{i}),dim,0);
end

% produce all permutatons of the candidates
for i=1:no_regions
    region_candidates = candidates{i};
    [N,M]=size(region_candidates);
    clear limits
    for j = 1:M
        limits(j) = M - j +1;
    end
    regional_solutions = [];
    for j=1:N
        indices = ones(1,M);
        for k = 1:factorial(M)
           template = region_candidates(j,:);
           L = M;
           clear perm
           possibles = template;
           for s = 1:M
               t = indices(s);
               perm(s) = possibles(t);
               if t==1
                   possibles = possibles(2:end);
               elseif t==M
                   possibles = possibles(1:M-1);
               else
                   possibles = [possibles(1:t-1),possibles(t+1:end)];
               end
           end
           indices = rightward_counter(indices,limits);
           regional_solutions =  [regional_solutions;perm];
        end
    end
    sol_before = regional_solutions
    % prune if a boxes are collinear\
    if linear_box(i) == 1
         regional_solutions = prune(regional_solutions);
    end        
    sol_after = regional_solutions
    solutions{i} = regional_solutions;
end
                        
% calculate number of possible solutions
no_possibles = 1;
for i=1:no_regions
    [N,M]= size(solutions{i});
    limits(i) = N;
    no_possibles = no_possibles*N;
end
no_possibles



% generate all possible combinations in grid and look for a correct one

indices = ones(1,no_regions);
ken_grid = zeros(dim,dim);

while i <= no_possibles
    for j=1:no_regions
        boxes = box_nos{j};
        candidate = solutions{j}(indices(j),:);
        for k = 1:length(boxes)
             ken_grid(boxes(k)) = candidate(k);
        end
    end
    grid_is_solution = check_grid(ken_grid,dim);
    if  grid_is_solution == 1
        break
    end
    indices=counter(indices,limits,no_regions);
    i=i+1;
end
if grid_is_solution
    ken_grid
else
    disp('no solution found')
end

function is_in_line = linear_check(boxes,dim)
% function to check if boxes are all in a row or column
% from a dim x dim array. 

N = length(boxes);
if N == 1
    is_in_line = 0;
else
    for k = 1:N
         [cl(k),rw(k)] = coord_calc(boxes(k),dim);
    end
    cl_check = sum(cl/max(cl) - ones(1,length(cl)));
    rw_check = sum(rw/max(rw) - ones(1,length(rw)));
    if cl_check == 0 || rw_check == 0
         is_in_line = 1;
    else
        is_in_line =0;
    end
end

function pruned_candidates = prune(candidates,linear_check)
      [M,N] = size(candidates);
      pruned_candidates = [];
      for k=1:M
            has_multiples = 0;
            sorted = sort(candidates(k,:));
            for m = 1:(length(candidates(k,:))-1)
                   if sorted(m) == sorted(m+1)
                        has_multiples = 1;
                        break
                   end
            end
            if has_multiples == 0
                 pruned_candidates = [pruned_candidates;candidates(k,:)];
            end
      end
                   

function [i,j]=coord_calc(k,dim)
% function to convert a column index of an array of dimension dim x dim
% to normal [i,j] format

    i = mod(k,dim);
    if i == 0
        i = dim;
    end
    j = ceil(k/dim);


function indices = counter(indices,limits,no_regions)
% 
for i=no_regions:-1:1
    if indices(i) < limits(i)
        indices(i) = indices(i)+1;
        break
    else
        indices(i) = 1;
    end
end
function indices = rightward_counter(indices,limits)
% 
for i=1:length(indices)
    if indices(i) < limits(i)
        indices(i) = indices(i)+1;
        break
    else
        indices(i) = 1;
    end
end
function grid_correct = check_grid(ken_grid,dim);

%function to check if rows or colums have repeat numbers

grid_correct = 1;
row_good = 1:dim;
for i = 1:dim
    ken_row = ken_grid(i,:);
    row_sort = sort(ken_row);
    if sum(row_sort - row_good) ~= 0
        grid_correct = 0;
        break
    end
end
if grid_correct == 1
     
    for j = 1:dim
        ken_col = ken_grid(:,j)';
        row_sort = sort(ken_col);
        if sum(row_sort - row_good) ~= 0
            grid_correct = 0;
            break
        end

    end
end

function print_puzzle(dim,ops,results,box_nos)

ken_grid = zeros(dim,dim);
for i=1:length(ops)
    boxes = box_nos{i};
    for k = 1:length(boxes)
        ken_grid(boxes(k)) = i;
    end
end
ken_grid_regions=ken_grid
for i = 1:length(ops)
    disp([num2str(i),' ',ops(i),num2str(results(i))])
end
        
% solutions{1} = [1];  % possible solutions to a regioin
% solutions{2} = [[2,3];[3,2]];
% solutions{3} = [[1,2];[2,1];[2,3];[3,2]];
% solutions{4} = [1];
% solutions{5} = [[2,1];[1,2]];
% solutions{6} = [3];


% function grids = solution_find(no_regions,region_no,dim,box_nos,solutions)
% 
% for i = 1:no_regions
%     if not filled grid
%          solution_find(no_regions,region_i,solution_j,dim,box_nos,solutions)
%     else
%           boxes = box_nos(region_i);
%           candidates = solutions{solution_j}
%           for k = 1:length(boxes)
%                ken_grid(boxes(i)) = candidates(solution_j;k);
%           end
                
% candidates{1} = [1];  % possible solutions to a region
% candidates{2} = [2,3];
% candidates{3} = [[1,2];[2,3]];
% candidates{4} = [1];
% candidates{5} = [2,1];
% candidates{6} = [3];

              
