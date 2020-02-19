source ~/.zshrc

# remove existing data file
rm MD_scan_on.txt

# turn off potential in the forcefield

#sed -i '' '167s/.*/ CBB    CAA     CAA     CBB     3 4.224 -17.732  -6.897  47.022 -97.060  57.245 /g' OBT.ff/ffOBT.itp
#this set is from the fit fn

#sed -i '' '167s/.*/ CBB    CAA     CAA     CBB     3 4.224 -17.732  -6.897  47.022 -95.060  57.245 /g' OBT.ff/ffOBT.itp
#this set best reproduces the flip barrier

#sed -i '' '167s/.*/ CBB    CAA     CAA     CBB     3 4.224 -17.732  -6.897  49.022 -92.060  48.245 /g' OBT.ff/ffOBT.itp
# reproduces the walls best


sed -i '' '167s/.*/ CBB    CAA     CAA     CBB     3 -0.6664   37.2462 -220.7564  421.7323 -400.5349  153.7185 /g' OBT.ff/ffOBT.itp

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
	3 4 11 12 1 $i 0 5000
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
