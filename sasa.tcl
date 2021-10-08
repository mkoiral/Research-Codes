
for { set i 109 } { $i < 198 } { incr i } {
set sel [atomselect top "protein"]
set sel2 [atomselect top "resid $i"]
set sasa [measure sasa 1.4 $sel -restrict $sel2]
echo $sasa
}


