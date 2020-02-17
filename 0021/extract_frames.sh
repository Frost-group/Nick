source ~/.zshrc

for i in $(seq 2000 100 4000)
do
	echo "0" | gmx trjconv -f NPT_cold.xtc -s NPT_cold.tpr -dump $i -o structure/NPT_cold_${i}ps.gro -pbc whole 
	gmx editconf -f structure/NPT_cold_${i}ps.gro -rotate 110 -58 -28 -o structure/NPT_cold_${i}ps_rot.gro -c
	rm ./structure/\#*
done
