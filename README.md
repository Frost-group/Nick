Folders containing relevant files for FF development for OBT,  Initially doing with fully glycolated sidechains

# Filename keys for QCC calculations
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
0001 = Gaussian opt and freq calculations of different olligomers related to OBT. QCC.
0002 = Forcefield development for OBT.  Folder set up as a MD run folder, and the forcefield parameters are in OBT.ff/ . This follows the FF2 scheme from Morena et. al. J Phys Chem. MD.    
	Code for residues - 	
		GI = glycolated sidechains, first unit
		GM = glycolated sidechains, middle unit
		GE = glycolated sidechains, end unit
		AI = alkylated sidechains, first unit
		AM = alkylated sidechains, middle unit
		AF = alkylated sidechains, end unit
		GS = tin-terminated monomer (Sn Me3 terminated) with glycole sidechains
		GB = Bromine terminated monomer with glycol sidecahins
		AS = tin-terminated monomer (Sn Me3 terminated) with alkylated sidechains
		AB = Bromine terminated monomer with alkylated sidechains
0003 = Calculation of partial charges for different arrangements of oligomers of OBT, using ChelpG. QCC
0004 = population calculations using the heavy atom terminations, for which we have the crystal structures. QCC
	_Sn = terminated with SN-(CH3)3 , _Br = terminated with Br atoms
0005 = Information on the forcefield contained in 0002.  Naming schemes and rules etc. Misc
0006 = Rerun calculations in 0001 and 0003 but using the wB97XD functional to include dispersion correction (Jarv recommend). QCC
0007 = O-angle scan files optimised. MD. QCC.
0008 = Inner-dihedral scan optimisation using RB function, first attempt. MD. QCC.
0009 = Inner-dihedral scan optimsation with non-bond between oxygen and sulfur. MD. QCC.
0010 = Outer-dihedral scan optimisation. MD. QCC.
0011 = Forcefield with optimised parameters. MD. 
0012 = Files containing information on crystal structures of monomers of OBT with either Br or Sn(Me)3 terminal groups. Misc.
0013 = Inner-dihedral optimised without the methyl groups. MD. QCC.
0014 = Inner-dihedral scan. different functionals and different sidechains. QCC.
0015 = Inner-dihedral scan, with individual files and calculations. QCC.
0016 = O-angle scan, different functionals and different sidechains. QCC.
0017 = Testing crystal structure stability for AB residue.  Initial test. MD.
0018 = Testing crystal structure stability for GS residue.  Initial test. MD. 
0019 = Outer-dihedral scan. different functionals, different sidechains and either two-monomers, or two-half-monomers. QCC.
0020 = Testing crystal structure stability for GS residue.  Second test, using different ES params. MD. 
0021 = Testing crystal structure stability for AB residue.  Anneal at 400K. MD. 
0022 = Same as 0017, but with adjusted O angle parameters. MD. 
0023 = Same as 0020, but with adjusted O angle parameters. MD. 
0024 = Outer-dihedral scan with MP2 and MP4 methods. QCC.
0025 = Outer-dihedral scan with CCSD method. QCC.
0026 = Testing crystal structure stability for AB residue.  Anneal at 350K. MD.
0027 = Literature on pi-pi stacking differences in alkylated and glycolated polymers. Literature.
0028 = Literature on charging dynamics in ionic liquids. Literature.
0029 = Summary slides on 0022 , 0021 , 0026 (alkylated) and 0020
