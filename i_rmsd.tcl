# Prints the i-RMSD of the protein atoms between each \timestep
# # # and the first \timestep for the given molecule id (default: top)
mol load parm7 /Desktop/Barnase_Barstar/result/complex.prmtop  dcd ./dcd/combine.dcd 
mol load pdb  /Desktop/Barnase_Barstar/result/complex_bound.pdb 
#mol addfile combine.dcd
# # # use frame 0 for the reference
set reference [atomselect 1 "(resid 1 to 108) and (name CA)"]
# # # the frame being compared
set compare [atomselect 0 "(resid 1 to 108) and (name CA)"]
set num_steps [molinfo 0 get numframes]
set outfile [open rmsd.dat w]

# # # compute the transformation
    set trans_mat [measure fit $compare $reference]
 # # # do the alignment
 #$compare move $trans_mat
 $all move $trans_mat
 # # # compute the RMSD
 set compare_lig [atomselect 0 "(resid 137 to 154) and (name CA) " frame $frame]
 set reference_lig [atomselect 1 "(resid 137 to 154) and (name CA)"]
 set rmsd [measure rmsd $compare_lig $reference_lig]
 # # # print the RMSD
 puts $outfile  "$frame  $rmsd "

close $outfile 
exit
