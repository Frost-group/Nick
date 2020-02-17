source ~/.zshrc

for i in $(seq 2000 200 8000)
do
	echo "0" | gmx trjconv -f NPT.xtc -s NPT.tpr -dump $i -o structure/NPT_${i}ps.gro -pbc whole
	gmx editconf -f structure/NPT_${i}ps.gro -rotate 110 -58 -28 -o structure/NPT_${i}ps_rot.gro -c
	rm ./structure/\#*
done
