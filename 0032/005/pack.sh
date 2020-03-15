source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output gly20.pdb 

structure GI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 7.95 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 15.9 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 23.85 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 31.8 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 39.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 47.7 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 55.65 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 63.6 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 71.55 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 79.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 87.45 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 95.4 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 103.35 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 111.3 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 119.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 127.2 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 135.15 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 143.1 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GE.pdb 
number 1 
center 
fixed 151.05 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

EOF

gmx editconf -f gly20.pdb -o gly20.gro
gmx editconf -f gly20.gro -o gly20.pdb
rm \#*
