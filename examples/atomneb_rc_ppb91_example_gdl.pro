; --- Begin $MAIN$ program. ---------------
; 

; Use Atomic Data Collection from the National Institute of Standards and Technology (NIST) 
; Atomic Spectra Database, the CHIANTI atomic database, and some improved atomic data from 
; Cloudy v13.04 and pyNeb v1.0

; Locate datasets
base_dir = '../'
data_dir = ['atomic-data-rc']
Atom_RC_file= filepath('rc_PPB91.fits', root_dir=base_dir, subdir=data_dir )

atom='c'
ion='iii' ; C II
; read Recombination Coefficients (Aeff) of C II
cii_rc_data=atomneb_read_aeff_ppb91(Atom_RC_file, atom, ion)
temp=size(cii_rc_data.Wavelength,/DIMENSIONS)
n_line=temp[0]
; print information needed for Recombination Coefficients (Aeff) of C II
for i=0,n_line-1 do print,cii_rc_data[i].Ion,cii_rc_data[i].Case1, $
                          cii_rc_data[i].Wavelength, cii_rc_data[i].a, $
                          cii_rc_data[i].b, cii_rc_data[i].c, $
                          cii_rc_data[i].d, cii_rc_data[i].br, $
                          cii_rc_data[i].Q, cii_rc_data[i].y

atom='c'
ion='iii'
; list all Recombination Coefficients (Aeff) data for C II
list_cii_aeff_data=atomneb_search_aeff_ppb91(Atom_RC_file, atom, ion)
; print all Recombination Coefficients (Aeff) of C II
print,list_cii_aeff_data

atom='c'
ion='iii'
; list all Recombination Coefficients (Aeff) references for C II
list_cii_aeff_reference=atomneb_list_aeff_ppb91_references(Atom_RC_file, atom, ion)
; print all Recombination Coefficients (Aeff) References for C II
print,list_cii_aeff_reference

atom='c'
ion='iii'
; get citations for Recombination Coefficients (Aeff) of C II
citation=atomneb_get_aeff_ppb91_reference_citation(Atom_RC_file, atom, ion)
; print citations for Recombination Coefficients (Aeff) of C II
print,citation

exit
