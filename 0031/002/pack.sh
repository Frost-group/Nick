source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output alk20.pdb 

structure AI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 7.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 15.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 23.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 31 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 38.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 46.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 54.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 62 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 69.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 77.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 85.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 93 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 100.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 108.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 116.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 124 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 131.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AM.pdb 
number 1 
center 
fixed 139.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure AE.pdb 
number 1 
center 
fixed 147.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

EOF

gmx editconf -f alk20.pdb -o alk20.pdb -box 15.4 2.3500 0.5844 -angles 65.27 79.95 80 -rotate 6 0 0
gmx genconf -f alk20.pdb -o super_cell.pdb -nbox 1 4 8
