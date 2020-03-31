source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output box.pdb 

structure alk20.pdb 
number 200 
inside box 0. 0. 0. 850 850 850 
end structure 
EOF

