source ~/.zshrc

cd ./0001/
dsd
scp HPC:$H/\*log .
scp HPC:$H/\*pdb .
scp HPC:$H/\*gjf .

cd ../0002/
dsd
scp HPC:$H/\*log .
scp HPC:$H/\*pdb .
scp HPC:$H/\*gjf .

cd ../0003/
dsd
scp HPC:$H/\*log .
scp HPC:$H/\*pdb .
scp HPC:$H/\*gjf .

cd ../File_Lib/
dsd
scp HPC:$H/\*log .
scp HPC:$H/\*pdb .
scp HPC:$H/\*gjf .

