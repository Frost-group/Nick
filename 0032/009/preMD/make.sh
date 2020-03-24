source ~/.zshrc

#gmx editconf -f mon.pdb -o mon.pdb -center 0.000 0.960 0.19 -angles 78.00  82.00 100.20
gmx editconf -f mon.pdb -o mon.pdb -center 0.000 0.920 0.19 -angles 90.00  72.00 90.00
sed -i '' 's/ P 1           1/     P21\/n/g' mon.pdb
open mon.pdb -a /Applications/CCDC/Mercury/mercury.app
