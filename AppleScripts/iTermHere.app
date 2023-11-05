(* 
    Open iTerm here 
     
    A toolbar script for Mac OS X 10.3+
     
    Written by Brian Schlining
    Modified by Jitendra Bodmann
*)


property debug : false


on run
	tell application "Finder"
		try
			set this_folder to (the target of the front window) as alias
		on error
			-- get the alias of the home folder of the current user
			set this_folder to path to home folder
		end try
		
		my process_item(this_folder)
		
	end tell
end run


on open these_items
	repeat with i from 1 to the count of these_items
		set this_item to item i of these_items
		my process_item(this_item)
	end repeat
end open


on process_item(this_item)
	
	set thePath to POSIX path of this_item
	set theCmd to "cd " & quote & thePath & quote & ";clear;"
	set wasRunning to true
	
	if application "iTerm" is not running then
		tell application "iTerm"
			activate
		end tell
		set wasRunning to false
		delay 0.3
	end if
	
	tell application "iTerm"
		
		set aWindow to current window
		
		if wasRunning is true then
			-- case app is running in background with no active window
			if aWindow is equal to missing value then
				set aWindow to (create window with default profile)
			else
				-- create's a new tab when app was running
				tell aWindow
					set t to (create tab with default profile)
				end tell
			end if
		end if
		
		tell current session of aWindow
			write text theCmd
		end tell
		
	end tell
	
	
end process_item
