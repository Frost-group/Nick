#Folders containing relevant files for FF development for OBT,  Initially doing with fully glycolated sidechains

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
Sn = terminated with SN-(CH3)3 , Br = terminated with Br atoms

#Code for residues - 	
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
MI = Glycolated with methyl spacer, first unit
MM = Glycolated with methyl spacer, middle unit
ME = Glycolated with methyl spacer, end unit
EI = Glycolated with ethyl spacer, first unit
EM = Glycolated with ethyl spacer, middle unit
EE = Glycolated with ethyl spacer, end unit
PI = Glycolated with propyl spacer, fist unit
PM = Glycolated with propyl spacer, fist unit
PE = Glycolated with propyl spacer, fist unit
BI = Glycolated with Butyl spacer, first unit
BM = Glycolated with methyl spacer, middle unit
BE = Glycolated with methyl spacer, end unit

# Main activity 
0001 = Gaussian opt and freq calculations of different olligomers related to OBT. QCC.
0003 = Calculation of partial charges for different arrangements of oligomers of OBT, using ChelpG. QCC
0004 = population calculations using the heavy atom terminations, for which we have the crystal structures. QCC
0006 = Rerun calculations in 0001 and 0003 but using the wB97XD functional to include dispersion correction (Jarv recommend). QCC
0007 = O-angle optimisatopm. MD. QCC.
0008 = Inner-dihedral scan optimisation first attempt. MD. QCC.
0009 = Inner-dihedral scan optimsation with non-bond between oxygen and sulfur. MD. QCC.
0010 = Outer-dihedral scan optimisation. MD. QCC.
0011 = Forcefield with optimised parameters. MD. 
0012 = Files containing information on crystal structures of monomers of OBT with either Br or Sn(Me)3 terminal groups. Misc.
0013 = Inner-dihedral optimised without the methyl groups. MD. QCC.
0014 = Inner-dihedral scan. different functionals and different sidechains. QCC.
0015 = Inner-dihedral scan, with individual files and calculations. QCC.
0016 = O-angle scan, different functionals and different sidechains. QCC.
0019 = Outer-dihedral scan. different functionals, different sidechains and either two-monomers, or two-half-monomers. QCC.
0024 = Outer-dihedral scan with MP2 and MP4 methods. QCC.
0029 = Testing Glycolated monomer Crystal Structures with Different EP Parameters. QCC. MD.
	0029/001 = Same as alkylated, and opls parameters for sidechains. MD.
		0029/001/300K = not annealed
		0029/001/350K = annealed at 350K
		0029/001/400K = annealed at 400K
	0029/002 = Gaussian using 'pop=MKUFF b3lyp/lanl2dz' and optimised structure. MD.
	0029/003 = Cheminformatics, QTPIE. MD.
	0029/004 = Cheminformatics, EEM. MD.
	0029/005 = Gaussian using 'pop=MKUFF b3lyp/lanl2dz', averaged over dihedral using boltzmann inversion for weightings. MD.
0030 = Annealing of alkylated monomer crystal. MD.
	0030/300K = not annealed
	0030/350K = annealed at 350K
	0030/400K = annealed at 400K
0031 = Crystal structure for alkylated polymer. MD.
	0031/001 = Initial trial structure, flat with lattice spacings from xray.  Angles to keep pi stack seen in monomer crystal. MD.
	0031/002 = Take the structure that 001 relaxes into, create super cell and re-run.  MD.
	0031/003 = Rerun 002 with bigger box to see if backbones stay straight.  MD.
0032 = Crystal structure for glycolated polymer. MD.
	0032/001 = Crystal structure, intiated flat with lattice parameters base on the xray, and angles to maintain same pi stacking as 0031. MD.
	0032/002 = Crystal structure.  All angles 90 degrees.  Sidechains curled, like in monomer crystal structure. MD.
0033 = Simulation of amorphous glykoxylated polymer. MD. 
0034 = Simulation of amorphous alkoxylated polymer. MD.
0035 = Gaussian files for making of glycolated polymer with methyl spacer, ethyl spacer, propyl spacer and butyl spacer.  QCC.
0036 = Gaussian calculations to look at sidechain-backbone interaction using PCM.  QCC.
0037 = Simulation of amorphous glykoxylated polymer with methyl spacer unit in the sidechain. MD.
0038 = Simulation of amorphous glykoxylated polymer with ethyl spacer unit in the sidechain. MD.
0039 = Simulation of amorphous glykoxylated polymer with propanyl spacer unit in the sidechain. MD.
