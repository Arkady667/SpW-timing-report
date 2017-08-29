#! /bin/env acttclsh

################# TEST  ##############################
# new_design -name "prepi" -family "ProASIC3E"
# save_design {prepi.adb}
# puts {TEST}
# close_design 
######################################################
set argv0 [lindex $::argv 0]
set argv1 [lindex $::argv 1]
set argv2 [lindex $::argv 2]
set argv3 [lindex $::argv 3]

# puts "$::argv0 is argv0"
# puts "$::argv1 is argv1"
# puts "$::argv2 is argv2"

set designFile {C:\Users\aczuba\TCL\spw_script\P3_DPU.adb} 
puts $designFile

open_design $designFile
	if  { [catch { open_design $designFile }]} { 
		puts "Failed to open design"
		# Handle Failure 
	} else { 
		puts "Design opened successfully"
		# Proceed to further processing 
	} 

puts "$::argv0 is argv0"
puts "$::argv1 is argv1"
puts "$::argv2 is argv2"
	# set createSet "-name { iToRegClk } -source { $::argv1 } -sink { $::argv2 }"
	st_create_set -name { iToRegClk } -source { $argv1 } -sink { $argv2 }

	if  { [catch { st_create_set -name { iToRegClk } -source { $argv1 } -sink { $argv2 }}]} { 
		puts "Failed to set path \n $::errorInfo \n $::errorCode"
		# Handle Failure 
	} else { 
		puts "Path created successfully "
		# Proceed to further processing 
	} 






st_list_paths -set { iToRegClk }

save_design {P3_DPU.adb}
close_design