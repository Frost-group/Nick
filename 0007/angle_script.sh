for i in $(seq 0 0.01 500)
do
	gmx trjconv -f Prod.xtc -o angle.gro -dump $i -s Prod.tpr -n O_angle.ndx > /dev/null 2>&1
	gmx angle -f angle.gro -n angle.ndx | grep "< angle >" >> angle.txt
	rm \#* 
	echo "done $i"
done
