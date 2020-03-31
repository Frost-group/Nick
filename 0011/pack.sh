source ~/.bash_profile

packmol << EOF
tolerance 2.0
filetype pdb
output but20.pdb 

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

structure BM.pdb 
number 1 
center 
fixed 15.7 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 23.55 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 31.4 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 39.25 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 47.1 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 54.95 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 62.8 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 70.65 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 78.5 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 86.35 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 94.2 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 102.05 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 109.9 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 117.75 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 125.6 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 133.45 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BM.pdb 
number 1 
center 
fixed 141.3 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

structure BE.pdb 
number 1 
center 
fixed 149.15 0 0 0 0 0
inside box 0. 0. 0. 0 0 0 
end structure 

EOF

rm \#*
