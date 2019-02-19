; docformat = 'rst'

function atomneb_read_aeff_ppb91_references, Atom_RC_file
;+
;     This function returns the reference list of recombination coefficients (Aeff) from the 2nd binary table extension
;     of the FITS data file ('rc_PPB91.fits').
;
; :Private:
;
; :Returns:
;    type=an array of data. This function returns the aeff_data_reference: 
;          { Reference:'',
;            Citation:''}
;
; :Params:
;     Atom_RC_file  : in, required, type=string
;                     the FITS data file name ('rc_PPB91.fits')
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
;     15/01/2017, IDL code by A. Danehkar
;-

;+
; NAME:
;     atomneb_read_aeff_o_ii_ssb17_references
;
; PURPOSE:
;     This function returns the reference list of recombination coefficients (Aeff) from the 2nd binary table extension
;     of the FITS data file ('rc_PPB91.fits').
;
; CALLING SEQUENCE:
;     aeff_data=atomneb_read_aeff_o_ii_ssb17_references(Atom_RC_file)
;
; INPUTS:
;     Atom_RC_file  : in, required, type=string, the FITS data file name ('rc_PPB91.fits')
;
; OUTPUTS:  This function returns an array data of the aeff_data_reference
;          { Reference:'',
;            Citation:''}
;
; PROCEDURE: This function is called by atomneb_get_aeff_ppb91_reference_citation. 
;            This function calls ftab_ext from IDL Astronomy User's library (../externals/astron/pro).
;
; MODIFICATION HISTORY:
;     15/01/2017, IDL code by A. Danehkar
;-
  reference_template={Reference:'', Citation: ''}
  
  ftab_ext,Atom_RC_file,[1,2],Reference,Citation,EXTEN_NO =2
  temp=size(Reference,/DIMENSIONS)
  reference_length=temp[0]
  
  reference_data=replicate(reference_template, reference_length)
  for i=0, reference_length-1 do begin 
     reference_data[i].Reference=strtrim(Reference[i])
     reference_data[i].Citation=strtrim(Citation[i])
  endfor
  return, reference_data
end

