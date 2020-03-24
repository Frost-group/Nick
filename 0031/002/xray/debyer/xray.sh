source ~/.zshrc

gmx genconf -f ../NPT.gro -o large.pdb -nbox 1 3 3  > /dev/null 2>&1
echo "done enlarge"
change_pdb_xyz large.pdb  > /dev/null 2>&1
echo "changed to xyz"
deb_change_atom_OBT large.xyz
echo "changed atom names"
debyer -x -vv -f0.02 -t2.0 -s0.002 large.xyz
plot_xray large.xq 500
open xray.pdf
