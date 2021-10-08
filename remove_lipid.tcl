#removes bad lipid and then saves the new psf
set path output_building
mol new /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean.psf
mol addfile /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean.pdb


set all [atomselect top all]
$all set beta 0

# find all lipids that overlap protein
set badl1 [atomselect top "lipid and same residue as within 0.8 of protein"]

$badl1 num


$badl1 set beta 1

set allbadlipid [atomselect top "resname POPC and beta > 0"]
set seglistlipid [$allbadlipid get segid]
set reslistlipid [$allbadlipid get resid]






# Now lets build a new psf & pdb w/o badlipids
mol delete all

package require psfgen
resetpsf

readpsf /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean.psf
coordpdb /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean.pdb

foreach segid $seglistlipid resid $reslistlipid {
   delatom $segid $resid
}




writepsf /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean_lipid.psf
writepdb /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean_lipid.pdb

mol new /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean_lipid.psf
mol addfile /Users/maheshkoirala/Desktop/Margo/crt_mem_solvated_ionized_wt_clean_lipid.pdb

