#! /bin/env tclsh

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

proc add_set {from to} {
	set createSet "-name { iToRegClk } -source { $from } -sink { $to }"
	st_create_set $createSet
	# st_create_set -name { dataToRegClk }\
	# 	 -source { $from }\
	# 	 -sink { $to }
	if  { [catch { st_create_set $createSet }]} { 
		puts "Failed to set path \n $::errorInfo \n $::errorCode"
		# Handle Failure 
	} else { 
		puts "Path created successfully "
		# Proceed to further processing 
	} 

}

# proc error {add_set_error} 
# {
# 	if  { [catch { st_create_set -name { iToRegClk } -source { $from } -sink { $to } }]} { 
# 		puts "Failed to set path"
# 		# Handle Failure 
# 	} else { 
# 		puts "Path created successfully"
# 		# Proceed to further processing 
# 	} 
# 	set resource [some allocator]
# 	if {[set result [catch {some code with $resource} resulttext]]} {
#     # remember global error state, as de-allocation may overwrite it
#     set einfo $::errorInfo
#     set ecode $::errorCode

#     # free the resource, ignore nested errors
#     catch {deallocate $resource}

#     # report the error with original details
#     return -code $result \
#            -errorcode $ecode \
#            -errorinfo $einfo \
#            $resulttext
# }
# deallocate $resource

# continue normally

# }

# proc gen_report {} {
# 	 report -type {timing} \
# 	 		-print_summary {no}\
# 	 		-analysis {max}\
# 	 		-print_paths {yes}\
# 	 		-include_user_sets {yes}\
# 	 		-include_pin_to_pin {no}\
# 	 		-include_clock_domains {yes}\
# 	 		spw_timing_report

# 	if  { [catch { report -type timing spw_timing_report -print_summary no -analysis max -print_paths yes -include_user_sets yes -include_pin_to_pin no -include_clock_domains yes -select_clock_domains $clock }]} { 
# 		puts "Failed generate SpaceWire timing report"
# 		# Handle Failure 
# 	} else { 
# 		puts "Timing SpaceWire report generated successfully"
# 		# Proceed to further processing 
# 	} 		

# }


proc main_exec {from to} {
	add_set $from $to
	# gen_report 

}
puts "$argv0 is argv0"
puts "$argv1 is argv1"
puts "$argv2 is argv2"
main_exec $argv1 $argv2 
st_list_paths -set { iToRegClk }

save_design {P3_DPU.adb}
close_design