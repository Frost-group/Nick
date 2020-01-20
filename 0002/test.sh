source ~/.zshrc

file="test"

#sh pack.sh
gmx editconf -f GB.pdb -o ${file}.gro -box 5 5 5
echo "1" | gmx pdb2gmx -f ${file}.gro
gmx grompp -f EM.mdp -p topol.top -r ${file}.gro -o temp.tpr
gmx mdrun -s temp.tpr -deffnm temp
gmx grompp -f NVT.mdp -p topol.top -r temp.gro -o nvt_temp.tpr
gmx mdrun -s nvt_temp.tpr -deffnm nvt_temp
rm \#*
rm *tpr
rm conf.gro
rm mdout.mdp
rm nvt_temp.cpt
rm nvt_temp.edr
rm nvt_temp.log
rm nvt_temp_prev.cpt
rm posre.itp
rm temp.edr
rm temp.gro
rm temp.log
rm temp.trr
