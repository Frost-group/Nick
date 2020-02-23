source ~/.zshrc

rm structure/*gro
rm structure/*pdb

for i in $(seq 20000 2000 30000)
do
	echo "0" | gmx trjconv -f ../NPT.xtc -s ../super_cell.pdb -dump $i -o NPT_${i}ps.pdb -pbc nojump
	sed -i '' 's/ [A-Z] /   /g' NPT_${i}ps.pdb
	rm \#*
done
