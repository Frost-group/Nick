Folders containing relevant files for FF development for OBT,  Initially doing with fully glycolated sidechains

# Filename keys
OT = oxythiophene

OBT = oxy-bi-thiophene

O0A = oxy-bi-thiophene with no alkylated bits on sidechains

Xm = number of monomers in file 

Xsc = number of atoms on the sidechains

b = before a gaussian calculation

a = after a gaussian calculation

ir = results from IR calculation

ram = results from raman calculation

# Other Files
File_lib = Folder containing useful structural files.  Including pdb fragment files from Gaussian which have been energy optimised

Temp_files = Folder containing any small unecessary intermediate files. Can be cleared periodically

# Main activity 
0001 = Gaussian opt and freq calculations of different olligomers related to OBT

0002 = Forcefield development for OBT.  Folder set up as a MD run folder, and the forcefield parameters are in OBT.ff/ . This follows the FF2 scheme from Morena et. al. J Phys Chem.   
	Code for residues - 	
		GI = glycolated sidechains, first unit
		GM = glycolated sidechains, middle unit
		GE = glycolated sidechains, end unit
		AI = alkylated sidechains, first unit
		AM = alkylated sidecahins, middle unit
		AF = alkylated sidecahins, end unit
		GS = tin-terminated monomer (Sn Me3 terminated) with glycole sidechains
		GB = Bromine terminated monomer with glycol sidecahins
		AS = tin-terminated monomer (Sn Me3 terminated) with alkylated sidechains
		AB = Bromine terminated monomer with alkylated sidecahins


0003 = Calculation of partial charges for different arrangements of oligomers of OBT, using ChelpG 

0004 = population calculations using the heavy atom terminations, for which we have the crystal structures
	_Sn = terminated with SN-(CH3)3 , _Br = terminated with Br atoms

0005 = Information on the forcefield contained in 0002.  Naming schemes and rules etc

0006 = rerun calculations in 0001 and 0003 but using the wB97XD functional to include dispersion correction (Jarv recommend).

0007 = O-angle scan files.  Gaussian scan performed by Drew P. 
