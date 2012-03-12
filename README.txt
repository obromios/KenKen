This is a repository for the KenKen project, or the early stages of it.

At this point in time the program does an exhaustive search to find a 
solution to the KenKen puzzle. This works for puzzles up to 4 and maybe 5
dimensions but breaks down after that  Further developments 
could be to add heuristics to prune search or to add a user interface.

For the user interface, one challenge is to work out if squares are
contiguous.  

An algorithm I have been considering is to set up an object

Class block
   i % column index
   j % row end
   % other attributes such as setting the borders to be on or off.
end

Clearly you can tell if one block is adjacent to another by working out if
it is plus or minus i or j and has the same j or i.

To find out if a candidate set of blocks is contiguous you could do as follows

U = all candidate blocks
C = c1 1st block
S = U - c_1

While C ^= U

contigyous = true
If ci is adjacent to any of C
     S = S - c_i
     C = C + C_i
     k=1
else
     if k == length (U)
          congigous = false
          break
     end
     k = k + 1
     rotate S
end


C. R. Drane
12/3/2012