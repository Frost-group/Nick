source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output box.pdb 

structure met20.pdb 
number 200 
inside box 0. 0. 0. 800 800 800 
end structure 
EOF

