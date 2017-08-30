#! /bin/env tclsh

################# TEST  ##############################
# new_design -name "prepi" -family "ProASIC3E"
# save_design {prepi.adb}
# puts {TEST}
# close_design 
######################################################
# running from cmd
# >designer "SCRIPT:spw.tcl iSpw0Stb iSpw0Dat *r.do*" "SCRIPT_DIR:C:\Users\aczuba\TCL\spw_script" "LOGFILE:spw_report.log"
######################################################
set argv0 [lindex $::argv 0]
set argv1 [lindex $::argv 1]
set argv2 [lindex $::argv 2]
set argv3 [lindex $::argv 3]

# set setNameStb {iSpwDatToReg}
# set setNameDat {ISpwStbToCLK}
set setSourceStb { iSpw0Stb }
set setSourceDat { iSpw0Dat }
set setSink { *r.do* }

puts "$argv0 is argv0"
puts "$argv1 is argv1"
puts "$argv2 is argv2"

set designFileTest {C:\Users\aczuba\TCL\spw_script\P3_DPU.adb} 
set designFile {C:\DPU FPGA repo v2\alllib\designs\P3CCB_RT\P3_DPU.adb}
puts $designFile

open_design $designFileTest
	if  { [catch { open_design $designFileTest }]} { 
		puts "Failed to open design"
		# Handle Failure 
	} else { 
		puts "Design opened successfully"
		# Proceed to further processing 
	} 

proc add_set {fromStb fromDat to} {
	set setNameDat {iSpwDatToReg}
	set setNameStb {iSpwStbToCLK}

	st_create_set -name  $setNameStb -source  $fromStb -sink  $to
	if  { [catch {st_create_set -name  $setNameStb -source  $fromStb -sink  $to }]} {
		puts "Failed to set path \n $::errorInfo \n $::errorCode"
		# Handle Failure 
	} else { 
		puts "Path created successfully "
		# Proceed to further processing 
	} 

	st_create_set -name $setNameDat -source $fromDat -sink  $to
	if  { [catch {st_create_set -name $setNameDat -source $fromDat -sink  $to }]} {
		puts "Failed to set path \n $::errorInfo \n $::errorCode"
		# Handle Failure 
	} else { 
		puts "Path created successfully "
		# Proceed to further processing 
	} 

}

proc clear_set {} {
	set setNameDat {iSpwDatToReg}
	set setNameStb {iSpwStbToCLK}


	st_remove_set -name $setNameStb
	if {[catch {st_remove_set -name $setNameStb}]} {
		puts "Path $setNameStb doesn't exist. Will be created new path\n $::errorInfo \n $::errorCode"
		# Handle Failure 
		continue
	} else {
		puts "Path $setNameStb will be overwrited successfully"
	}
	st_remove_set -name $setNameDat
	if {[catch {st_remove_set -name $setNameDat}]} {
	puts "Path $setNameDat doesn't exist. Will be created new path\n $::errorInfo \n $::errorCode"		# Handle Failure 
		continue
	} else {
		puts "Path $setNameDat will be overwrited successfully"
	}
	
}

proc list_set {} {
	set setNameDat {iSpwDatToReg}
	set setNameStb {iSpwStbToCLK}

	st_list_paths -set $setNameStb
	st_list_paths -set $setNameDat 
	if  { [catch st_list_paths -set $setNameStb] || [catch st_list_paths -set $setNameDat]} {
		puts "Failed to read sets \n $::errorInfo \n $::errorCode"
		# Handle Failure 
		continue
	} else { 
		puts "Sets read successfully."
		# Proceed to further processing
	}


}

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


proc main_exec {fromStb fromDat to} {
	add_set $fromStb $fromDat $to
	list_set
	clear_set
	# gen_report 

}

main_exec $argv0 $argv1 $argv2
st_commit
# st_list_paths -set {iSpwDatToReg}
puts "$argv0 is argv0"
puts "$argv1 is argv1"
puts "$argv2 is argv2"
st_commit
save_design {P3_DPU.adb}
close_design