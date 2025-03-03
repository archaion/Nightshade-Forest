# File: progress-dialog.tcl

# Purpose: a window with a label and progress bar

#
# Copyright (c) 1997-2009 Tim Baker
#
# This software may be copied and distributed for educational, research, and
# not for profit purposes provided that this copyright and statement are
# included in all such copies.
#

namespace eval NSProgressDialog {

# namespace eval NSProgressDialog
}

# NSProgressDialog::NSProgressDialog --
#
#	Object constructor called by NSObject::New().
#
# Arguments:
#	arg1					about arg1
#
# Results:
#	What happened.

proc NSProgressDialog::NSProgressDialog {oop} {

	InitWindow $oop

	return
}

# NSProgressDialog::Info --
#
#	Query and modify info.
#
# Arguments:
#	arg1					about arg1
#
# Results:
#	What happened.

proc NSProgressDialog::Info {oop info args} {

	global NSProgressDialog

	# Set info
	if {[llength $args]} {
		switch -- $info {
			ratio {
				NSProgress2::SetDoneRatio [Info $oop progId] [lindex $args 0]
			}
			default {
				set NSProgressDialog($oop,$info) [lindex $args 0]
			}
		}

	# Get info
	} else {
		switch -- $info {
			default {
				return $NSProgressDialog($oop,$info)
			}
		}
	}

	return
}

# NSProgressDialog::InitWindow --
#
#	Description.
#
# Arguments:
#	arg1					about arg1
#
# Results:
#	What happened.

proc NSProgressDialog::InitWindow {oop} {

	set win .progress$oop
	toplevel $win
	wm title $win Progress
	
	# Do stuff when window closes
	wm protocol $win WM_DELETE_WINDOW "NSProgressDialog::Close $oop"

	wm resizable $win no no
	wm withdraw $win

	Info $oop win $win

	set frame $win.frameProgress
	frame $frame \
		-borderwidth 0
	label $frame.prompt \
		-textvariable NSProgressDialog($oop,prompt) -anchor w
	set progId [NSObject::New NSProgress2 $frame 225 8]
	Info $oop progId $progId

	pack $frame.prompt \
		-side top -fill x
	pack $::NSProgress2($progId,frame) \
		-side top -anchor nw
	pack $frame \
		-side top -padx 10 -pady 15

	return
}

# NSProgressDialog::Close --
#
#	Do something when closing the window.
#
# Arguments:
#	arg1					about arg1
#
# Results:
#	What happened.

proc NSProgressDialog::Close {oop} {

	destroy [Info $oop win]
	NSObject::Delete NSProgressDialog $oop

	return
}

