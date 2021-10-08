#removes bad water and then saves the new psf
set path output_building
mol new /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_g132v.psf
mol addfile /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_g132v.pdb

set all [atomselect top all]
$all set beta 0

# find all waters that overlap protein
set badw1 [atomselect top "water and same residue as within 3 of protein"]

# remove waters that are in the hydrocarbon region. These can only come from the solvate
# plugin and therefore have segnames that begin with WT (or whatever you used)
set badw2 [atomselect top "segid WT1 to WT99 and same residue as abs(z) < 25"]

$badw1 num
$badw2 num

$badw1 set beta 1
$badw2 set beta 1

set allbadwater [atomselect top "name OH2 and beta > 0"]
set seglistwater [$allbadwater get segid]
set reslistwater [$allbadwater get resid]

# Now lets build a new psf & pdb w/o badwaters
mol delete all
package require psfgen
resetpsf
readpsf /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_g132v.psf
coordpdb /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_g132v.pdb

foreach segid $seglistwater resid $reslistwater {
   delatom $segid $resid
}

writepsf /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_wt_clean_g132v.psf
writepdb /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_wt_clean_g132v.pdb

mol new /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_wt_clean_g132v.psf
mol addfile /Users/maheshkoirala/Desktop/lipid_md/G132V/crt_mem_solvated_ionized_wt_clean_g132v.pdb

