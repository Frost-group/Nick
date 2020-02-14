source ~/.zshrc

for i in $(seq 200 10 500)
do
	echo "0" | gmx trjconv -f NPT.xtc -s NPT.tpr -dump $i -o structure/NPT_${i}ps.gro
	gmx editconf -f structure/NPT_${i}ps.gro -rotate 110 -58 -28 -o structure/NPT_${i}ps_rot.gro
	rm ./structure/\#*
done
