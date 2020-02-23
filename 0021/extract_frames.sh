source ~/.zshrc

rm structure/*gro
rm structure/*pdb

for i in $(seq 50000 2000 60000)
do
	echo "0" | gmx trjconv -f NPT_cold.xtc -s super_cell.pdb -dump $i -o structure/NPT_${i}ps.pdb -pbc nojump
	sed -i '' 's/ [A-Z] /   /g' ./structure/NPT_${i}ps.pdb
	rm ./structure/\#*
done
