source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output B_olig.pdb 

structure BI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 7.85 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BE.pdb 
number 1 
center 
fixed 15.7 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 


EOF

