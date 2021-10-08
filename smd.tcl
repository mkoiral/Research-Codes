set sel [atomselect top all]

$sel set beta 0
$sel set occupancy 0

##set Consraint

set sel2 [atomselect top "resname SER"]
$sel2 set beta 5
set sel3 [atomselect top all]
$sel3 writepdb crt_constr_mem_g87r.pdb

##set SMD

set sel4 [atomselect top all]
$sel4 set beta 0
$sel4 set occupancy 0

set sel5 [atomselect top "resname CRN"]
$sel5 set occupancy 1
set sel6 [atomselect top all]
$sel6 writepdb crt_constr_ref_g87r.pdb

