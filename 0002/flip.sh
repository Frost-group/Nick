source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output PMFF.pdb 


structure PMF.pdb 
number 1 
center 
fixed 0 0 0 3.14 3.14 1.57
inside box 0. 0. 0. 0 0 0 
end structure 
EOF
