source ~/.zshrc

rm structure/NPT*gro

for i in $(seq 1500 10 2000)
do
	echo "0" | gmx trjconv -f NPT.xtc -s NPT.tpr -dump $i -o structure/NPT_${i}ps.gro

	gmx editconf -f structure/NPT_${i}ps.gro  -o structure/NPT_${i}ps_rot.gro -rotate 0 -40 -65 -n odd.ndx 

	gmx editconf -f structure/NPT_${i}ps_rot.gro -o structure/NPT_${i}ps_rot.gro -c

	rm ./structure/\#*
done
