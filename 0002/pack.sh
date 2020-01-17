source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output olig.pdb 


structure GI.pdb 
number 1 
center 
fixed -7.950 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GM.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure GE.pdb 
number 1 
center 
fixed 7.95 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

EOF
