; docformat = 'rst'

function atomneb_search_aeff_n_ii_fsl13, Atom_RC_file, atom, ion, wavelength
;+
;     This function searches effective recombination coefficients (Aeff) for given element
;     and ionic levels in the FITS data file ('rc_n_iii_FSL13.fits'), and returns the data entry.
;
; :Returns:
;    type=array of data. This function returns the Aeff_Data.
;
; :Params:
;     Atom_RC_file  : in, required, type=string
;                     the FITS data file name ('rc_n_iii_FSL13.fits')
;     atom          : in, required, type=string
;                     atom name e.g. 'n'
;     ion           : in, required, type=string
;                     ionic level e.g 'iii'
;
; :Keywords:
;     wavelength    : in, type=float
;                     set the wavelengths
; :Examples:
;    For example::
;
;     IDL> base_dir = file_dirname(file_dirname((routine_info('$MAIN$', /source)).path))
;     IDL> data_rc_dir = ['atomic-data-rc']
;     IDL> Atom_RC_file= filepath('rc_n_iii_FSL13.fits', root_dir=base_dir, subdir=data_rc_dir )
;     IDL> atom='n'
;     IDL> ion='iii' ; N II
;     IDL> wavelength=5679.56
;     IDL> list_nii_aeff_data=atomneb_search_aeff_n_ii_fsl13(Atom_RC_file, atom, ion, wavelength)
;     IDL> print,list_nii_aeff_data.Wavelength
;        5679.56
;     IDL> print,list_nii_aeff_data.Aeff
;        7810.00      1780.00      850.000      151.000      74.4000      53.1000      47.4000
;        7370.00      1700.00      886.000      206.000      110.000      80.1000      70.8000
;        7730.00      1680.00      900.000      239.000      138.000      103.000      92.9000
;        8520.00      1710.00      905.000      244.000      142.000      107.000      97.0000
;
; :Categories:
;   Recombination Lines
;
; :Dirs:
;  ./
;      Main routines
;
; :Author:
;   Ashkbiz Danehkar
;
; :Copyright:
;   This library is released under a GNU General Public License.
;
; :Version:
;   0.0.1
;
; :History:
;     03/07/2017, IDL code by A. Danehkar
;-

;+
; NAME:
;     atomneb_search_aeff_n_ii_fsl13
;     
; PURPOSE:
;     This function searches effective recombination coefficients (Aeff) for given element
;     and ionic levels in the FITS data file ('rc_n_iii_FSL13.fits'), and returns the data entry.
;
; CALLING SEQUENCE:
;     list_aeff_data=atomneb_search_aeff_n_ii_fsl13(Atom_RC_file, atom, ion, wavelength)
; 
; INPUTS:
;     Atom_RC_file  : in, required, type=string, the FITS data file name ('rc_n_iii_FSL13.fits')
;     Atom          : in, required, type=string, atom name e.g. 'n'
;     Ion           : in, required, type=string, ionic level e.g 'iii'
;
; KEYWORD PARAMETERS:
;     WAVELENGTH    : in, type=float, set the wavelengths
; 
; OUTPUTS:  This function returns an array of data as the Aeff_Data.
; 
; PROCEDURE: This function calls atomneb_read_aeff_n_ii_fsl13_list and 
;            fits_read from IDL Astronomy User's library (../externals/astron/pro).
; 
; EXAMPLE:
;     base_dir = file_dirname(file_dirname((routine_info('$MAIN$', /source)).path))
;     data_rc_dir = ['atomic-data-rc']
;     Atom_RC_file= filepath('rc_n_iii_FSL13.fits', root_dir=base_dir, subdir=data_rc_dir )
;     atom='n'
;     ion='iii' ; N II
;     wavelength=5679.56
;     list_nii_aeff_data=atomneb_search_aeff_n_ii_fsl13(Atom_RC_file, atom, ion, wavelength)
;     print,list_nii_aeff_data.Wavelength
;     > 5679.56
;     print,list_nii_aeff_data.Aeff
;     > 7810.00      1780.00      850.000      151.000      74.4000      53.1000      47.4000
;     > 7370.00      1700.00      886.000      206.000      110.000      80.1000      70.8000
;     > 7730.00      1680.00      900.000      239.000      138.000      103.000      92.9000
;     > 8520.00      1710.00      905.000      244.000      142.000      107.000      97.0000
;
; MODIFICATION HISTORY:
;     03/07/2017, IDL code by A. Danehkar
;-  
  element_data_list=atomneb_read_aeff_n_ii_fsl13_list(Atom_RC_file)
  
  ii=where(element_data_list.wavelength eq wavelength)
  
  temp=size(ii,/DIMENSIONS)
  ii_length=temp[0]
  if ii_length eq 1 then begin
    if ii eq -1 then begin
      print, 'could not find the given wavelength'
      exit
    endif
  endif
  Extention1=element_data_list[ii].Extention
  Wavelength1=element_data_list[ii].wavelength
  
  rc_element_template={Wavelength: float(0.0), Aeff:fltarr(7,4)}
  Select_Aeff_Data=replicate(rc_element_template, ii_length)
  for i=0, ii_length-1 do begin 
    fits_read,Atom_RC_file,rc_aeff,header1,EXTEN_NO =Extention1[ii]
    Select_Aeff_Data[i].Wavelength=Wavelength1[ii]
    Select_Aeff_Data[i].Aeff[*,*]=rc_aeff[*,*]
  endfor
  return, Select_Aeff_Data
end
