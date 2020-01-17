source ~/.zshrc

sh pack.sh
gmx editconf -f olig.pdb -o olig.gro -box 5 5 5
echo "1" | gmx pdb2gmx -f olig.gro
gmx grompp -f EM.mdp -p topol.top -r olig.gro -o temp.tpr
gmx mdrun -s temp.tpr -deffnm temp
gmx grompp -f NVT.mdp -p topol.top -r temp.gro -o nvt_temp.tpr
gmx mdrun -s nvt_temp.tpr -deffnm nvt_temp
rm \#*
rm *tpr
