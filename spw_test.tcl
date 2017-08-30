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

set setName { iSpwToReg }
set setSourceStb { iSpw0Stb }
set setSourceDat { iSpw0Dat }
set setSink { *r.do* }
puts $setName


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
# st_create_set -name { iSpwToReg } -source { iSpw0* } -sink  { *r.do* }  
st_create_set -name  $setName -source  $setSourceStb -source $setSourceDat -sink  $setSink  
	if  { [catch {st_create_set -name  $setName -source  $setSourceStb -source $setSourceDat -sink  $setSink }]} {
		puts "Failed to set path \n $::errorInfo \n $::errorCode"
		# Handle Failure 
	} else { 
		puts "Path created successfully "
		# Proceed to further processing 
	} 
st_commit

# st_list_paths -set { iToRegClk }


puts "$::argv0 is argv0"
puts "$::argv1 is argv1"
puts "$::argv2 is argv2"
save_design {P3_DPU.adb}
close_design