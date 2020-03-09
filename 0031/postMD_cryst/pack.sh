source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output pol.pdb 

structure temp.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 


EOF

