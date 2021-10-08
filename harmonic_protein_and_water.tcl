mol new /Users/maheshkoirala/Desktop/lipid_md/I598M/crt_mem_solvated_ionized_wt_clean_i598m.psf
mol addfile /Users/maheshkoirala/Desktop/lipid_md/I598M/crt_mem_solvated_ionized_wt_clean_i598m.pdb
set all [atomselect top "all"]
$all set beta 0
set prot [atomselect top "protein or water"]
$prot set beta 1
$all writepdb /Users/maheshkoirala/Desktop/lipid_md/I598M/constrained_water_and_protein_i598m.pdb

