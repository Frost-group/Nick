source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output GSF.pdb 

structure GS.pdb
number 1 
center 
fixed 0 0 0 3.14 3.14 0
inside box 0. 0. 0. 10 10 10
end structure 

EOF




