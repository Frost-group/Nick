source ~/.zshrc

cd ./0001/
dsd
scp HPC:$H/\*log . > /dev/null 2>&1
scp HPC:$H/\*pdb . > /dev/null 2>&1
scp HPC:$H/\*txt . > /dev/null 2>&1

cd ../0002/
dsd
scp HPC:$H/\*log . > /dev/null 2>&1
scp HPC:$H/\*pdb . > /dev/null 2>&1
scp HPC:$H/\*txt . > /dev/null 2>&1

cd ../0003/
dsd
scp HPC:$H/\*log . > /dev/null 2>&1
scp HPC:$H/\*pdb . > /dev/null 2>&1
scp HPC:$H/\*txt . > /dev/null 2>&1

cd ../File_Lib/
dsd
scp HPC:$H/\*log . > /dev/null 2>&1
scp HPC:$H/\*pdb . > /dev/null 2>&1
scp HPC:$H/\*txt . > /dev/null 2>&1
