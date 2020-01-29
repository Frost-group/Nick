source ~/.zshrc

# remove existing data file
rm MD_scan_off.txt

# turn off potential in the forcefield
sed -i '' '162s/.*/ ST     CAA     CAA     ST      3       0 0 0 0 0 0/g' OBT.ff/ffOBT.itp
sed -i '' '163s/.*/ ST     CAA     CAA     CBB     3       0 0 0 0 0 0/g' OBT.ff/ffOBT.itp

# Loop over the different angle restraints
for i in $(seq 120 2 240)
do

	gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
	echo "1" | gmx pdb2gmx -f mon.gro
	
	(
	cat <<- EOF 
	#include "./OBT.ff/forcefield.itp"
	#include "mon.itp"
	
	[ system ]
	Struc
	
	[ molecules ]
	mon	1
	
	[ dihedral_restraints ]
	; ai   aj    ak    al   type  phi  dphi  kfac
	  5     1     9    13     1    $i   0   1000000
	EOF
	) > topol.top
	
	rm posre.itp
	
	gmx grompp -f EM.mdp -c mon.gro -p topol.top -o EM.tpr
	gmx mdrun -s EM.tpr -deffnm EM	

	j=$((i-180))	
	a=$(grep "Potential Energy" EM.log | awk '{print $4}')
	echo "$j     $a" >> MD_scan_off.txt	
	rm \#*

done

# Remove unnecessary files
rm EM.edr EM.gro EM.log EM.tpr EM.trr conf.gro mdout.mdp mon.gro 
