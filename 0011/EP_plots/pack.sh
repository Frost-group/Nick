source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output gly3.pdb 

structure ../GI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure ../GM.pdb 
number 1 
center 
fixed 9 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure ../GE.pdb 
number 1 
center 
fixed 18 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 


EOF


packmol << EOF
tolerance 2.0
filetype pdb
output alk3.pdb 

structure ../AI.pdb 
number 1 
center 
fixed 0 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure ../AM.pdb 
number 1 
center 
fixed 9 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure ../AE.pdb 
number 1 
center 
fixed 18 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 


EOF
