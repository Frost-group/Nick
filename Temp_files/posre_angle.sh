source ~/.zshrc

for i in $(seq 100 1 130)
do
	#b=$((180-$i))
	b=$i

	gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
	echo "1" | gmx pdb2gmx -f mon.gro

	echo "[ angle_restraints ]" > posre.itp
	echo "; i j k l            type    theta0     fc             mult" >> posre.itp
	echo "1 2 2 6 1 $b 100000 1" >> posre.itp

	gmx grompp -f EM.mdp -p topol.top -r mon.gro -o EM.tpr -maxwarn 1
	gmx mdrun -s EM.tpr -deffnm EM

	a=$(grep "Potential Energy" EM.log | awk '{print $4}')
	echo "$b     $a" >> angle_scan.txt
done

rm \#*
