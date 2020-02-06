source ~/.zshrc

# remove existing data file
rm MD_scan_on.txt

# turn off potential in the forcefield
sed -i '' '163s/.*/ ST     CAA     CAA     CBB     3 0 0 0 0 0 0 /g' OBT.ff/ffOBT.itp
sed -i '' '164s/.*/ CBB    CAA     CAA     CBB     3 -4.45  -74.01  199.66 -367.01  266.70  -63.00 /g' OBT.ff/ffOBT.itp



# Loop over the different angle restraints
for i in $(seq -180 10 180)
do	
	gmx editconf -f mon.pdb -o mon.gro -box 5 5 5
	echo "1" | gmx pdb2gmx -f mon.gro
	rm posre.itp

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
	3 4 11 12 1 $i 0 2000
	EOF
	) > topol.top
		
	gmx grompp -f EM.mdp -r mon.gro -p topol.top -o EM.tpr -maxwarn 1
	gmx mdrun -s EM.tpr -deffnm EM		

	a=$(grep "Potential Energy" EM.log | awk '{print $4}')
	echo "$i     $a" >> MD_scan_on.txt	
	rm \#*

done

# Remove unnecessary files
rm EM.edr EM.gro EM.log EM.tpr EM.trr conf.gro mdout.mdp mon.gro 
