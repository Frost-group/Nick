import os
import pandas as pd
import matplotlib.pyplot as plt
os.chdir("/Users/nicholassiemons/Dropbox/OBT/0007/")

def main():

	# plot the gaussian energy scan result	
	Gscan = pd.read_table("gT2_Oanglescan_tot_ener.txt",skiprows=4, delim_whitespace=True, header=None)
	Gscan.columns = ['Angle', 'E_H']	
	Gscan['method'] = "Gaussian"
	Gscan['E_diff_H'] = Gscan['E_H'] - Gscan['E_H'].iloc[0]
	Gscan['E_mev'] = Gscan['E_diff_H'] * 27.2114E3
	
	plt.plot(Gscan['Angle'], Gscan['E_mev'], marker='o')
	plt.xlabel("angle, degrees")
	plt.ylabel("energy, meV")
	plt.legend(['Gaussian'])
	plt.title("Energy of C-C-O angle in OBT")
	plt.savefig("Gscan.pdf")
	plt.close()

	# plot the total energy of the monomer from MD
	MD_tot_energy = pd.read_table("angle.xvg",skiprows=1000, delim_whitespace=True, header=None, nrows=50000)
	MD_tot_energy.columns = ['time', 'E_kjmol', 'angle']
	MD_tot_energy = MD_tot_energy.dropna()
	MD_tot_energy = MD_tot_energy.sort_values(by='angle',ascending=0)

	binned = pd.DataFrame(columns=['angle','energy'])
	bin_no = 20
	bin_size = int(MD_tot_energy.count()[1] / bin_no)
	for i in range(0,bin_no):
		j = i*bin_size
		binned.loc[i,'angle'] = MD_tot_energy['angle'].iloc[j:j+bin_size].mean(axis=0)
		binned.loc[i,'energy'] = MD_tot_energy['E_kjmol'].iloc[j:j+bin_size].mean(axis=0)

	plt.plot(binned['angle'], binned['energy'], marker='o')
	plt.xlabel("angle, degrees")
	plt.ylabel("Energy, Kjmol-1")
	plt.legend(['MD with potential turned off'])
	plt.title("Energy of C-C-O angle with angle potential turned off")
	plt.savefig("MD_scan.pdf")
	plt.close()	


if __name__ == '__main__': main()
