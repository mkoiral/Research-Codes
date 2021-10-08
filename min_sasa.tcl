
#$file will contain the file pointer to text.txt (file myst exist)

set file [open pdb_name.txt]

# $input will contain the contents of the file

set input [read $file]

# $lines will be an array containing each line of test.txt

set lines [split $input "\n"]

#Loop through each line

foreach line $lines {

	#Do Something with line here
	puts $line


	##set output [open $line r]
        ## Example script that sets the "User" data field with SASA values
	##
	mol delete all
	mol addfile $line
	##
	## Get list of residues
	##
	
	set allsel [atomselect top all]
	set protein [atomselect top "protein"]
	set output [open "SASA_$line.dat" w]
	##
	## Make an atomselection , set the user field with the SASA value for the selected atom
	##
	foreach r $protein {
	set sasa [measure sasa 1.4 $protein -restrict $allsel]
	$allsel delete
	puts "no $line, sasa:$sasa"
	puts $output "residue $line  sasa: $sasa"
}
	mol delete $line
	close $output
}
